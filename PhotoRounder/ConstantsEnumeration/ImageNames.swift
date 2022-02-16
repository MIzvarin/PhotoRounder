//
//  ImageNames.swift
//  PhotoRounder
//
//  Created by Максим Изварин on 10.02.2022.
//

import UIKit
import SwiftUI

enum Images: String {
    case magic = "ВЖУХ"
    case handmade = "scissors"
    case removeImage = "clear.fill"
    case photo = "photo"
    case plus = "plus"
    
    func getImage() -> Image {
        switch self {
        case .magic:
            return Image(uiImage: UIImage(named: self.rawValue)!)
        default:
            return Image(systemName: self.rawValue)
        }
    }
}
