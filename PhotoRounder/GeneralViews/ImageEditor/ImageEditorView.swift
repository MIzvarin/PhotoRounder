//
//  ImageEditor.swift
//  PhotoRounder
//
//  Created by Максим Изварин on 02.03.2022.
//

import SwiftUI
import Mantis

struct ImageEditorView: UIViewControllerRepresentable {
	typealias Coordinator = ImageEditorCoordinator
	
	// MARK: - Public properties
	@EnvironmentObject var viewModel: ViewModel
	@Environment(\.presentationMode) var presentationMode
	let image: UIImage
	
	// MARK: - UIViewControllerRepresentable
	func makeCoordinator() -> Coordinator {
		ImageEditorCoordinator(self)
	}
	
	func makeUIViewController(context: UIViewControllerRepresentableContext<ImageEditorView>) -> Mantis.CropViewController {
		let editor = Mantis.cropViewController(image: image)
		editor.config.cropShapeType = .circle(maskOnly: true)
		editor.config.presetFixedRatioType = .alwaysUsingOnePresetFixedRatio(ratio: 1.0 / 1.0)
		editor.delegate = context.coordinator
		return editor
	}
	
	func updateUIViewController(_ uiViewController: CropViewController, context: Context) {}
	
	// MARK: - Private functions
	func saveCroppedPhoto(_ croppedPhoto: UIImage) {
		viewModel.saveCropppedPhoto(for: image, croppedPhoto: croppedPhoto)
		presentationMode.wrappedValue.dismiss()
	}
}
