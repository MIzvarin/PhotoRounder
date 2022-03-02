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
	var sourceImage: UIImage? {
		viewModel.photos.searchKey(for: selectedImage)
	}
	
	// MARK: - Private properties
	@State private var imageEditorIsPresented = false
	
	
	// MARK: - Body
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
							ImageEditorView(image: sourceImage ?? UIImage())
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
