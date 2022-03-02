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
	@State var selectedImage: UIImage
	let displayMode: DisplayMode
	
	@State private var imageEditorIsPresented = false
	
	var body: some View {
		let photos = getPhotosList()
		
		TabView(selection: $selectedImage) {
			ForEach(photos, id: \.self) { photo in
				HStack {
					Image(uiImage: photo)
						.resizable()
						.scaledToFit()
				}.frame(maxWidth: .infinity, maxHeight: .infinity)
					.tag(photo)
					.overlay(
						ManualCroppingButton(action: {
							imageEditorIsPresented.toggle()
						}).fullScreenCover(isPresented: $imageEditorIsPresented, content: {
							ImageEditor(image: $selectedImage, isShowing: $imageEditorIsPresented)
						})
							.padding(),
						alignment: .bottomLeading)
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
