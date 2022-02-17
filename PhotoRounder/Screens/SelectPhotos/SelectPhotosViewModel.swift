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
		let square = getSquareForCropping(sourceImage: sourceImage, faceRect: faceRect)
		
		let renderer = UIGraphicsImageRenderer(size: square.size)

		let result = renderer.image { _ in
			let breadthRect = CGRect(origin: .zero, size: square.size)
			let circle = UIBezierPath(ovalIn: breadthRect)
			
			circle.addClip()
			
			if let cgImage = sourceImage.cgImage?.cropping(to: CGRect(origin: .zero, size: breadthRect.size)) {
				UIImage(cgImage: cgImage, scale: sourceImage.scale, orientation: sourceImage.imageOrientation).draw(in: breadthRect)
			}
		}
		
		return result
	}
	
	private func getSquareForCropping(sourceImage: UIImage,faceRect: CGRect) -> CGRect {
		let center = CGPoint(x: faceRect.midX, y: faceRect.midY)
		var sideSize: CGFloat
		let smallerDistanceByX = min((1 - faceRect.midX), faceRect.midX)
		let smallerDistanceByY = min((1 - faceRect.midY), faceRect.midY)
		
		if smallerDistanceByX < smallerDistanceByY {
			sideSize = sourceImage.size.width * smallerDistanceByX * 2
		} else {
			sideSize = sourceImage.size.height * smallerDistanceByY * 2
		}
		
		return CGRect(center: center, sideSize: sideSize)
	}
}
