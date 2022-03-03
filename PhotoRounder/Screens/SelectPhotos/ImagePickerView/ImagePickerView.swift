//
//  ImagePicker.swift
//  PhotoRounder
//
//  Created by Максим Изварин on 10.02.2022.
//

import PhotosUI
import SwiftUI

struct ImagePickerView: UIViewControllerRepresentable {
	// MARK: - Public properties
    @Environment(\.presentationMode) var presentationMode
    let configuration: PHPickerConfiguration
    let startingHandler: () -> Void
    let completionHandler: (_ selectedPhotos: [UIImage]) -> Void

    // MARK: - Init
    init(
        configuration: PHPickerConfiguration,
        startingHandler: @escaping () -> Void,
        completionHandler: @escaping (_ selectedPhotos: [UIImage]) -> Void) {
        self.configuration = configuration
        self.startingHandler = startingHandler
        self.completionHandler = completionHandler
    }

    // MARK: - Public functions
    func makeUIViewController(context: Context) -> PHPickerViewController {
        let controller = PHPickerViewController(configuration: configuration)
        controller.delegate = context.coordinator
        return controller
    }

    func updateUIViewController(_: PHPickerViewController, context _: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}
