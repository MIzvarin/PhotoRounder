//
//  Colors.swift
//  PhotoRounder
//
//  Created by Максим Изварин on 10.02.2022.
//

import SwiftUI

enum Colors {
    case main
    case helperText
    case magic

    func getColor() -> Color {
        switch self {
        case .main:
            return .blue.opacity(0.85)

        case .helperText:
            return .gray

        case .magic:
            return Color(.sRGB, red: 23/255, green: 114/255, blue: 69/255)
        }
    }
}
