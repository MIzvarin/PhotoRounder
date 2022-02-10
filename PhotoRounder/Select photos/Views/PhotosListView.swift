//
//  PhotosListView.swift
//  PhotoRounder
//
//  Created by Максим Изварин on 10.02.2022.
//

import SwiftUI

struct PhotosListView: View {
    //MARK: - Private properties
    
    private let spacing: CGFloat = 2
    
    //MARK: - Public properties
    
    ///binding
    @Binding var selectedPhotos: [UIImage]
    
    //MARK: - Body
    
    var body: some View {
        VStack {
            if selectedPhotos.isEmpty {
                Text(Labels.noSelectedPhotos.rawValue)
                    .foregroundColor(Colors.helperText.getColor())
                    .fontWeight(.medium)
            } else {
                let columnCount = selectedPhotos.count < 3  ? selectedPhotos.count : 3
                
                ScrollView(.vertical, showsIndicators: true) {
                    LazyVGrid(columns: Array(repeating: GridItem(spacing: spacing), count: columnCount), spacing: spacing) {
                        ForEach(selectedPhotos, id: \.self) { photo in
                            Image(uiImage: photo)
                                .resizable()
                                .scaledToFill()
                                .cornerRadius(spacing)
                        }
                    }
                }
            }
        }.padding([.leading, .trailing], spacing)
    }
}

//struct PhotosListView_Previews: PreviewProvider {
//    static var previews: some View {
//        PhotosListView()
//    }
//}
