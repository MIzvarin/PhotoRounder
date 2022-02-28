//
//  ImagePickerView+Coordinator.swift
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
            self.parent.startingHandler()
            let dispatchGroup = DispatchGroup()
            let queue = DispatchQueue.global(qos: .userInteractive)
            var selectedPhotos: [UIImage] = []

            queue.async(group: dispatchGroup) {
                results.forEach { selectedPhoto in
                    dispatchGroup.enter()

                    selectedPhoto.itemProvider.loadObject(ofClass: UIImage.self) { selectedPhoto, error in
                        if let error = error {
                            print("Error: \(error)")
                            return
                        }

                        guard let uiImage = selectedPhoto as? UIImage else { return }

                        selectedPhotos.append(uiImage)
                        dispatchGroup.leave()
                    }
                }
            }

            dispatchGroup.notify(queue: .main) { [weak self] in
                self?.parent.completionHandler(selectedPhotos)
            }

            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
