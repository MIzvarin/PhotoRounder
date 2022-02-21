//
//  PhotosListView.swift
//  PhotoRounder
//
//  Created by Максим Изварин on 10.02.2022.
//

import SwiftUI

struct PhotosListView: View {
    // MARK: - Private properties

    private let spacing: CGFloat = 2

    // MARK: - Public properties

    @EnvironmentObject var viewModel: SelectPhotosViewModel

    // MARK: - Body

    var body: some View {
        VStack {
            let columnCount = calculateColumnsNumber()

            if viewModel.photos.isEmpty {
                Text(Labels.noSelectedPhotos.rawValue)
                    .foregroundColor(Colors.helperText.getColor())
            } else {
                ScrollView(.vertical, showsIndicators: true) {
                    let gridItems = Array(repeating: GridItem(spacing: spacing), count: columnCount)
                    let photos = Array(viewModel.photos.keys)

                    LazyVGrid(columns: gridItems, spacing: spacing) {
                        ForEach(photos, id: \.self) { photo in
                            Photo(image: photo, removeAction: { image in
                                // Removal animation
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    _ = viewModel.photos.removeValue(forKey: image)
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

    // MARK: - Private functions

    private func calculateColumnsNumber() -> Int {
        viewModel.photos.count < 3  ? viewModel.photos.count : 3
    }
}
