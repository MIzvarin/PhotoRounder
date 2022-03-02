//
//  SelectPhotosViewModel.swift
//  PhotoRounder
//
//  Created by Максим Изварин on 10.02.2022.
//

import Combine
import UIKit
import Vision

final class ViewModel: ObservableObject {
    // MARK: Public properties

    /// key - source image
    /// value - cropped image
    @Published private(set) var photos: [UIImage: UIImage] = [:]

    // MARK: - Public functions

    func downloadPhotos(_ selectedPhotos: [UIImage]) {
		var tmpPhotos: [UIImage: UIImage] = [:]
		let targetSize = CGSize(width: 768, height: 1024)
		selectedPhotos.forEach { selectedPhoto in
			tmpPhotos[selectedPhoto.downsample(to: targetSize) ?? selectedPhoto] = UIImage()
		}
		photos = tmpPhotos
    }

    func removePhoto(_ photo: UIImage) {
        photos.removeValue(forKey: photo)
    }
	
	func saveCropppedPhoto(for sourcePhoto: UIImage, croppedPhoto: UIImage) {
		let rect = CGRect(origin: .zero, size: croppedPhoto.size)
		photos[sourcePhoto] = roundPhoto(sourcePhoto: croppedPhoto, faceRect: rect)
	}

    func autoCroppPhotos(completionHandler: @escaping () -> Void) {
        let dispatchGroup = DispatchGroup()
        let queue = DispatchQueue.global(qos: .utility)
        var tmpPhotos: [UIImage: UIImage] = [:]

        queue.async(group: dispatchGroup) { [weak self] in
			guard let self = self else { return }
			
            self.photos.keys.forEach { photo in
                dispatchGroup.enter()
                self.photoHandler(on: photo) { croppedPhoto in
                    tmpPhotos[photo] = croppedPhoto
                    dispatchGroup.leave()
                }
            }

            dispatchGroup.notify(queue: .main) { [weak self] in
                self?.photos = tmpPhotos
                completionHandler()
            }
        }
    }
	
    // MARK: - Private functions

    private func photoHandler(on photo: UIImage, completionHandler: @escaping (UIImage) -> Void) {
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

		let squareForCropp = getSquareForCropping(sourceImage: photo, faceRect: detectedFaceRect)
        let croppedImage = roundPhoto(sourcePhoto: photo, faceRect: squareForCropp)
        completionHandler(croppedImage)
    }

    private func roundPhoto(sourcePhoto: UIImage, faceRect: CGRect) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: faceRect.size)

        let circleCroppedImage = renderer.image { _ in
            let drawRect = CGRect(origin: .zero, size: faceRect.size)
            let circle = UIBezierPath(ovalIn: drawRect)
            circle.addClip()

            if let cgImage = sourcePhoto.cgImage?.cropping(to: faceRect) {
                UIImage(
                    cgImage: cgImage,
                    scale: sourcePhoto.scale,
                    orientation: sourcePhoto.imageOrientation
                ).draw(in: drawRect)
            }
        }

        return circleCroppedImage
    }

    private func getSquareForCropping(sourceImage: UIImage, faceRect: CGRect) -> CGRect {
        var sideSize: CGFloat

        let smallerDistanceByX = min((1 - faceRect.midX), faceRect.midX)
        let smallerDistanceByY = min((1 - faceRect.midY), faceRect.midY)
        let center = CGPoint(
            x: sourceImage.size.width * faceRect.midX,
            y: sourceImage.size.height * (1 - faceRect.midY)
        )

        if smallerDistanceByX < smallerDistanceByY {
            sideSize = sourceImage.size.width * smallerDistanceByX * 2
        } else {
            sideSize = sourceImage.size.height * smallerDistanceByY * 2
        }

        return CGRect(center: center, size: CGSize(width: sideSize, height: sideSize))
    }
}
