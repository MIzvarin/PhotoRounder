//
//  ImagePickerView + Coordinator.swift
//  PhotoRounder
//
//  Created by Максим Изварин on 16.02.2022.
//

import PhotosUI

extension ImagePickerView {
    
    // MARK: - Coordinator
    
    class Coordinator: PHPickerViewControllerDelegate {
        // MARK: - Static properties
        
        let parent: ImagePickerView
        
        // MARK: - Init
        
        init(_ parent: ImagePickerView) {
            self.parent = parent
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: - PHPickerViewController delegate
        
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
