//
//  ImageEditor+Coordinator.swift
//  PhotoRounder
//
//  Created by Максим Изварин on 02.03.2022.
//

import Mantis
import SwiftUI

extension ImageEditor {
	
	class ImageEditorCoordinator: CropViewControllerDelegate {
		@Binding var image: UIImage
		@Binding var isShowing: Bool
		
		init(image: Binding<UIImage>, isShowing: Binding<Bool>) {
			_image = image
			_isShowing = isShowing
		}
		
		func cropViewControllerDidCrop(_ cropViewController: CropViewController, cropped: UIImage, transformation: Transformation, cropInfo: CropInfo) {
			image = cropped
			isShowing = false
		}
		
		func cropViewControllerDidFailToCrop(_ cropViewController: CropViewController, original: UIImage) {
			
		}
		
		func cropViewControllerDidCancel(_ cropViewController: CropViewController, original: UIImage) {
			isShowing = false
		}
		
		func cropViewControllerDidBeginResize(_ cropViewController: CropViewController) {
			
		}
		
		func cropViewControllerDidEndResize(_ cropViewController: CropViewController, original: UIImage, cropInfo: CropInfo) {
			
		}
		
		
	}
}
