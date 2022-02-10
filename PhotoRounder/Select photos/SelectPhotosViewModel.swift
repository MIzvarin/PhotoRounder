//
//  SelectPhotosViewModel.swift
//  PhotoRounder
//
//  Created by Максим Изварин on 10.02.2022.
//

import Combine
import UIKit
import SwiftUI

class SelectPhotosViewModel: ObservableObject {
    @Published var selectedPhotos: [UIImage] = []
}
