//
//  PhotosListView.swift
//  PhotoRounder
//
//  Created by Максим Изварин on 10.02.2022.
//

import SwiftUI

struct PhotosListView: View {
	// MARK: - Public properties
	@EnvironmentObject var viewModel: ViewModel
	let displayMode: DisplayMode
	
	// MARK: - Body
	var body: some View {
		VStack {
			let columnCount = calculateColumnsNumber()
			
			if viewModel.photos.isEmpty {
				Text(Labels.noSelectedPhotos.rawValue)
					.foregroundColor(Colors.helperText.getColor())
			} else {
				ScrollView(.vertical, showsIndicators: true) {
					let gridItems = Array(repeating: GridItem(spacing: Constants.spacing), count: columnCount)
					let photos = displayMode == .showSourcePhotos ? Array(viewModel.photos.keys)
					: Array(viewModel.photos.values)
					
					LazyVGrid(columns: gridItems, spacing: Constants.spacing) {
						ForEach(photos, id: \.self) { photo in
							Photo(image: photo)
						}
					}
				}.padding([.leading, .trailing], Constants.spacing)
			}
		}
	}
	
	// MARK: - Private functions
	private func calculateColumnsNumber() -> Int {
		viewModel.photos.count < Constants.columnsCount  ? viewModel.photos.count : Constants.columnsCount
	}
}

// MARK: - Extensions
fileprivate extension PhotosListView {
	enum Constants {
		static let columnsCount = 3
		static let spacing: CGFloat = 2
	}
}
