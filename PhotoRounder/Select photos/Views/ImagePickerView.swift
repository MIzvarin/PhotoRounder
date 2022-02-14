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
    
    //MARK: - Init
    
    init(configuration: PHPickerConfiguration, completion: @escaping (_ selectedImage: UIImage) -> Void) {
        self.configuration = configuration
        self.completion = completion
    }
    
    //MARK: - Public functions
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        let controller = PHPickerViewController(configuration: configuration)
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_: PHPickerViewController, context _: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    //MARK: - Coordinator
    
    class Coordinator: PHPickerViewControllerDelegate {
        //MARK: - Static properites
        
        let parent: ImagePickerView
        
        //MARK: - Init
        
        init(_ parent: ImagePickerView) {
            self.parent = parent
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        //MARK: - PHPickerViewController delegate
        
        func picker(_: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            for image in results {
                image.itemProvider.loadObject(ofClass: UIImage.self) { selectedPhoto, error in
                    if let error = error {
                        print("Error: \(error)")
                        return
                    }

                    guard let uiImage = selectedPhoto as? UIImage else {
                        print("unable to unwrap image as UIImage")
                        return
                    }

                    print("Success")
                    DispatchQueue.main.async {
                        self.parent.completion(uiImage)
                    }
                }
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
