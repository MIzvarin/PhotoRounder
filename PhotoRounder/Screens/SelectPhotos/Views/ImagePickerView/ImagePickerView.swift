//
//  ImagePicker.swift
//  PhotoRounder
//
//  Created by Максим Изварин on 10.02.2022.
//

import PhotosUI
import SwiftUI

struct ImagePickerView: UIViewControllerRepresentable {
    
    @Environment(\.presentationMode) var presentationMode
    let configuration: PHPickerConfiguration
    let completion: (_ selectedImage: UIImage) -> Void
    
    // MARK: - Init
    
    init(configuration: PHPickerConfiguration, completion: @escaping (_ selectedImage: UIImage) -> Void) {
        self.configuration = configuration
        self.completion = completion
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
