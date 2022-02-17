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
	@Published var croppedImages: [UIImage] = []
	
	// MARK: - Public functions
	
	func downloadPhoto(_ photo: UIImage) {
		selectedPhotos.append(photo)
	}
	
	func removeAllPhotos() {
		selectedPhotos.removeAll()
	}
	
	// MARK: - Private functions
	func imageHandler(on image: UIImage)  {
		guard let cgImage = image.cgImage else { return }
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
		
		
		let croppedImage = croppImage(sourceImage: image, faceRect: detectedFaceRect)
		croppedImages.append(croppedImage)
	}
	
	private func croppImage(sourceImage: UIImage, faceRect: CGRect) -> UIImage {
		let originSize = sourceImage.size
		let faceWidth = originSize.width * faceRect.size.width
		let faceHeight = originSize.height * faceRect.size.height
		let dfgd = CGRect(origin: .zero, size: CGSize(width: faceWidth, height: faceHeight))
		let renderer = UIGraphicsImageRenderer(size: originSize)
		
		let result = renderer.image { _ in
			let breadthSize = dfgd.size
			let breadthRect = CGRect(origin: .zero, size: breadthSize)
			let origin = CGPoint(x: originSize.width * faceRect.origin.x, y: originSize.height * (1 - faceRect.origin.y))
			
			// ================================
			
			let circle = UIBezierPath(ovalIn: breadthRect)
			circle.addClip()
			if let cgImage = sourceImage.cgImage?.cropping(to: CGRect(origin: origin, size: breadthSize)) {
				UIImage(cgImage: cgImage, scale: sourceImage.scale, orientation: sourceImage.imageOrientation).draw(in: dfgd)
			}
		}
		return result
	}
	
	private func getSquareForCropping(faceRect: CGRect) -> CGRect {
		let center = CGPoint(x: faceRect.midX, y: faceRect.midY)
		let smallerDistanceByX = min((1 - faceRect.midX), faceRect.midX)
		let smallerDistanceByY = min((1 - faceRect.midY), faceRect.midY)
		let smallerDistance = min(smallerDistanceByY, smallerDistanceByX)
		let sideSize = smallerDistance * 2
		
		return CGRect(center: center, sideSize: sideSize)
	}
}
