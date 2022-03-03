//
//  ImageEditor+Coordinator.swift
//  PhotoRounder
//
//  Created by Максим Изварин on 02.03.2022.
//

import Mantis
import SwiftUI

extension ImageEditorView {
	// MARK: - Image editor coordinator
	class ImageEditorCoordinator: CropViewControllerDelegate {
		
		// MARK: - Public properties
		let parent: ImageEditorView
		
		// MARK: - Init
		init(_ parent: ImageEditorView) {
			self.parent = parent
		}
		
		// MARK: - CropViewControllerDelegate
		func cropViewControllerDidCrop(_ cropViewController: CropViewController, cropped: UIImage, transformation: Transformation, cropInfo: CropInfo) {
			parent.saveCroppedPhoto(cropped)
		}
		
		func cropViewControllerDidCancel(_ cropViewController: CropViewController, original: UIImage) {
			parent.presentationMode.wrappedValue.dismiss()
		}
		
		func cropViewControllerDidBeginResize(_ cropViewController: CropViewController) { }
		
		func cropViewControllerDidEndResize(_ cropViewController: CropViewController, original: UIImage, cropInfo: CropInfo) { }
		
		func cropViewControllerDidFailToCrop(_ cropViewController: CropViewController, original: UIImage) {
			
		}
	}
}
