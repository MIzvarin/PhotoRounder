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
            let columnCount = selectedPhotos.count < 3  ? selectedPhotos.count : 3
            
            if selectedPhotos.isEmpty {
                Text(Labels.noSelectedPhotos.rawValue)
                    .foregroundColor(Colors.helperText.getColor())
            } else {
                ScrollView(.vertical, showsIndicators: true) {
                    LazyVGrid(columns: Array(repeating: GridItem(spacing: spacing), count: columnCount), spacing: spacing) {
                        ForEach(selectedPhotos, id: \.self) { photo in
                            Photo(image: photo, removeAction: { image in
                                guard let index = selectedPhotos.firstIndex(of: image) else { return }
                                //Removal animation
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    _ = selectedPhotos.remove(at: index)
                                }
                            })
                                .scaledToFill()
                                .cornerRadius(spacing)
                                .animation(.easeIn, value: 1)
                        }
                    }
                }.padding([.leading, .trailing], spacing)
            }
        }
    }
}

//struct PhotosListView_Previews: PreviewProvider {
//    static var previews: some View {
//        PhotosListView()
//    }
//}
