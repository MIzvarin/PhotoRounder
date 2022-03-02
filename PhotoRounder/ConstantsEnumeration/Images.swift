//
//  ImageNames.swift
//  PhotoRounder
//
//  Created by Максим Изварин on 10.02.2022.
//

import SwiftUI
import UIKit

enum Images: String {
    case magic = "ВЖУХ"
    case handmade = "scissors"
    case removeImage = "clear.fill"
    case photo = "photo"
    case plus = "plus"
    case backButton = "arrow.left"
	case scissors = "scissors.circle"

    func getImage() -> Image {
        switch self {
        case .magic:
            return Image(uiImage: UIImage(named: self.rawValue) ?? UIImage())

        default:
            return Image(systemName: self.rawValue)
        }
    }
}
