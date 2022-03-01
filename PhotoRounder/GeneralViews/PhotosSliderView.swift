//
//  PhotosSliderView.swift
//  PhotoRounder
//
//  Created by Максим Изварин on 21.02.2022.
//

import SwiftUI

struct PhotosSliderView: View {
	// MARK: - Public properies
	@EnvironmentObject var viewModel: ViewModel
	let displayMode: DisplayMode
	
    var body: some View {
		let photos = getPhotosList()
		
		TabView {
			ForEach(photos, id: \.self) { photo in
				Photo(image: photo)
			}
		}.tabViewStyle(PageTabViewStyle())
    }
	
	// MARK: - Pivate functions
	private func getPhotosList() -> [UIImage] {
		if displayMode == .showSourcePhotos {
			return Array(viewModel.photos.keys)
		} else {
			return Array(viewModel.photos.values)
		}
	}
}

struct PhotosSliderView_Previews: PreviewProvider {
    static var previews: some View {
		PhotosSliderView(displayMode: .showSourcePhotos)
			.environmentObject(ViewModel())
    }
}
