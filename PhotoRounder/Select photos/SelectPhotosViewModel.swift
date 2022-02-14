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

    //MARK: - Public functions
    
    func downloadPhoto(_ photo: UIImage) {
        selectedPhotos.append(photo)
    }
    
    func removeAllPhotos() {
        selectedPhotos.removeAll()
    }
    
    //MARK: - Private functions
    private func detectFace() {
        
    }
}
