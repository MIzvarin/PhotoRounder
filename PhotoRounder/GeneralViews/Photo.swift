//
//  Photo.swift
//  PhotoRounder
//
//  Created by Максим Изварин on 11.02.2022.
//

import SwiftUI

struct Photo: View {
    // MARK: - Private properties
    @State private var showPhotosSlider = false
    private let removeImagePadding: CGFloat = 5

    // MARK: - Public properties
	@EnvironmentObject var viewModel: ViewModel
    let image: UIImage
	var displayMode: DisplayMode {
		if viewModel.photos[image] != nil {
			return .showSourcePhotos
		} else {
			return .showCroppedPhotos
		}
	}

    // MARK: - Body

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Button {
                showPhotosSlider.toggle()
            } label: {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }.sheet(isPresented: $showPhotosSlider) {
				PhotosSliderView(selectedImage: image, displayMode: displayMode)
            }
        }
    }
}

// MARK: - Preview

struct Photo_Previews: PreviewProvider {
    static var previews: some View {
        Photo(image: UIImage(named: Images.magic.rawValue) ?? UIImage())
			.environmentObject(ViewModel())
    }
}
