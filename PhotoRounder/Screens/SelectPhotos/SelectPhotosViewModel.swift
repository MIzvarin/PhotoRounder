//
//  SelectPhotosViewModel.swift
//  PhotoRounder
//
//  Created by Максим Изварин on 10.02.2022.
//

import Combine
import UIKit
import Vision

final class SelectPhotosViewModel: ObservableObject {
	// MARK: Public properties

	@Published var selectedPhotos: [UIImage] = []
	var croppedPhotos: [UIImage] = []

	// MARK: - Public functions

	func downloadPhoto(_ photo: UIImage) {
		selectedPhotos.append(photo)
	}

    func croppPhotos(completionHandler: @escaping () -> Void) {
        let dispatchGroup = DispatchGroup()

        selectedPhotos.forEach { photo in
            dispatchGroup.enter()
            photoHandler(on: photo) {
                dispatchGroup.leave()
            }
        }

        dispatchGroup.notify(queue: .main) {
            completionHandler()
        }
    }

    private func test(completionHandler: @escaping () -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
            completionHandler()
        }
    }

	// MARK: - Private functions
    private func photoHandler(on photo: UIImage, completionHandled: @escaping () -> Void) {
		guard let cgImage = photo.cgImage else { return }
		lazy var detectedFaceRect = CGRect()

		let request = VNDetectFaceRectanglesRequest { request, error in
			if let error = error {
				print("Error: \(error)")
				return
			}
			// Must be only one face
			guard
				let faceObservation = request.results?.first as? VNFaceObservation,
				request.results?.count == 1
			else {
				return
			}

			detectedFaceRect = faceObservation.boundingBox
		}

		let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
		try? handler.perform([request])

		let croppedImage = croppPhoto(sourcePhoto: photo, faceRect: detectedFaceRect)
		croppedPhotos.append(croppedImage)
        completionHandled()
	}

	private func croppPhoto(sourcePhoto: UIImage, faceRect: CGRect) -> UIImage {
		let cropSquare = getSquareForCropping(sourceImage: sourcePhoto, faceRect: faceRect)
		let renderer = UIGraphicsImageRenderer(size: cropSquare.size)

		let circleCroppedImage = renderer.image { _ in
			let drawRect = CGRect(origin: .zero, size: cropSquare.size)
			let circle = UIBezierPath(ovalIn: drawRect)
			circle.addClip()

			if let cgImage = sourcePhoto.cgImage?.cropping(to: cropSquare) {
				UIImage(cgImage: cgImage, scale: sourcePhoto.scale, orientation: sourcePhoto.imageOrientation).draw(in: drawRect)
			}
		}

		return circleCroppedImage
	}

	private func getSquareForCropping(sourceImage: UIImage, faceRect: CGRect) -> CGRect {
		var sideSize: CGFloat

		let smallerDistanceByX = min((1 - faceRect.midX), faceRect.midX)
		let smallerDistanceByY = min((1 - faceRect.midY), faceRect.midY)
		let center = CGPoint(x: sourceImage.size.width * faceRect.midX, y: sourceImage.size.height * (1 - faceRect.midY))

		if smallerDistanceByX < smallerDistanceByY {
			sideSize = sourceImage.size.width * smallerDistanceByX * 2
		} else {
			sideSize = sourceImage.size.height * smallerDistanceByY * 2
		}

		return CGRect(center: center, size: CGSize(width: sideSize, height: sideSize))
	}
}
