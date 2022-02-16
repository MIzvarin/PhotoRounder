//
//  Photo.swift
//  PhotoRounder
//
//  Created by Максим Изварин on 11.02.2022.
//

import SwiftUI

struct Photo: View {
    
    //MARK: - Private properties
    
    private let removeImagePadding: CGFloat = 5
    
    //MARK: - Public properties
    
    let image: UIImage
    let removeAction: (UIImage) -> Void
    
    //MARK: Init
    
    init(image: UIImage, removeAction: @escaping (UIImage) -> Void) {
        self.image = image
        self.removeAction = removeAction
    }
    
    //MARK: - Body
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
            
            Button {
                removeAction(image)
            } label: {
                Images.removeImage.getImage()
                    .foregroundColor(.gray)
                    .padding([.top, .trailing], removeImagePadding)
            }
        }
    }
}

    //MARK: - Preview

struct Photo_Previews: PreviewProvider {
    static var previews: some View {
        Photo(image: UIImage(named: Images.magic.rawValue)!) { _ in }
    }
}
