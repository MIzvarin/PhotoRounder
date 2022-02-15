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
    //MARK: Public properties
    
    @Published var selectedPhotos: [UIImage] = []
    @Published var croppedImages: [UIImage] = []

    //MARK: - Public functions
    
    func downloadPhoto(_ photo: UIImage) {
        selectedPhotos.append(photo)
    }
    
    func removeAllPhotos() {
        selectedPhotos.removeAll()
    }
    
    //MARK: - Private functions
    private func detectFace(on image: UIImage)  {
		guard let cgImage = image.cgImage else { return }
		
		let request = VNDetectFaceRectanglesRequest(completionHandler: detectFaceCompletionHandler(request:error:))
		let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
		
		try? handler.perform([request])
    }
	
	private func detectFaceCompletionHandler(request: VNRequest, error: Error?) {
		if let _ = error {
			print("Error was detected during face recognition")
			return
		}
		
		//Must be only one face
		guard request.results?.count == 1 else {
			print("Too much faces")
			return
		}
		
		guard let face = request.results?.first as? VNFaceObservation else { return }
		
		//Face coordinates in percent
		
		print(face)
	}
}
