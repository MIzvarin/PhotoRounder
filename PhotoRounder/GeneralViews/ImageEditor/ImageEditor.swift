//
//  ImageEditor.swift
//  PhotoRounder
//
//  Created by Максим Изварин on 02.03.2022.
//

import SwiftUI
import Mantis

struct ImageEditor: UIViewControllerRepresentable {
	typealias Coordinator = ImageEditorCoordinator
	
	@Binding var image: UIImage
	@Binding var isShowing: Bool
	
	func makeCoordinator() -> Coordinator {
		return ImageEditorCoordinator(image: $image, isShowing: $isShowing)
	}
	
	func makeUIViewController(context: UIViewControllerRepresentableContext<ImageEditor>) -> Mantis.CropViewController {
		let editor = Mantis.cropViewController(image: image)
		editor.config.cropShapeType = .circle(maskOnly: true)
		editor.config.presetFixedRatioType = .alwaysUsingOnePresetFixedRatio(ratio: 1.0 / 1.0)
		editor.delegate = context.coordinator
		return editor
	}
	
	func updateUIViewController(_ uiViewController: CropViewController, context: Context) {}
}
