//
//  ActionButton.swift
//  PhotoRounder
//
//  Created by Максим Изварин on 10.02.2022.
//

import SwiftUI

struct ActionButton: View {
    //MARK: - Public properties
    let text: String?
    let image: Image
    let action: () -> Void
    
    
    //MARK: - Private properties
    
    private let imageSize: CGFloat = 20
    private let buttonWidth: CGFloat = 200
    private let buttonHeight: CGFloat = 30
    private let cornerRadius: CGFloat = 10
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                image
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
                
                Text(text ?? "")
            }.frame(width: buttonWidth, height: buttonHeight)
        }
    }
    
    
}

struct ActionButton_Previews: PreviewProvider {
    static var previews: some View {
        ActionButton(text: "123", image: Image(systemName: "photo")) {
            print("123")
        }
    }
}
