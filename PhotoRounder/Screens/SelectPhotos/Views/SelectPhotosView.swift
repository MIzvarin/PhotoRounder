//
//  SelectPhotosView.swift
//  PhotoRounder
//
//  Created by Максим Изварин on 10.02.2022.
//

import PhotosUI
import SwiftUI

struct SelectPhotosView: View {
    // MARK: - Public properties

    @ObservedObject private var viewModel = SelectPhotosViewModel()

    // MARK: - Private properties

    @State private var showPhotoLibrary = false
    private let pickerConfiguration: PHPickerConfiguration = {
        var configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        configuration.filter = .images
		configuration.selectionLimit = Constants.selectionLimit
        return configuration
    }()
    private var isActionButtonDisabled: Bool {
        viewModel.selectedPhotos.isEmpty
    }

    // MARK: - Init

    init() {
        setupNavBarAppearance()
    }

    // MARK: - Body

    var body: some View {
        NavigationView {
            VStack {
                // Selected photos list
                PhotosListView(selectedPhotos: $viewModel.selectedPhotos)
					.frame(maxWidth: .infinity, maxHeight: .infinity)

                // Auto handling photos button
                Button {
                } label: {
                    HStack {
                        Images.magic.getImage()
                            .resizable()
                            .frame(width: Constants.imageSize, height: Constants.imageSize)

                        Text(Labels.magic.rawValue)
                            .foregroundColor(isActionButtonDisabled ? Colors.helperText.getColor() : Colors.magic.getColor())
                    }
                }.padding()
                    .disabled(isActionButtonDisabled)
            }.navigationTitle(Labels.selectedPhotos.rawValue)
                .toolbar(content: {
                    // Add photos button
                    Button {
                        showPhotoLibrary.toggle()
                    } label: {
                        Images.plus.getImage()
                            .foregroundColor(.white)
                    }.sheet(isPresented: $showPhotoLibrary) {
                        ImagePickerView(configuration: pickerConfiguration) { selectedImage in
                            viewModel.downloadPhoto(selectedImage)
                        }
                    }
                })
                .padding([.top], Constants.topPadding)
        }.navigationViewStyle(.stack)
    }

    // MARK: - Private functions

    private func setupNavBarAppearance() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = UIColor(Colors.main.getColor())
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    }
}

// MARK: - Preview

struct SelectPhotosView_Previews: PreviewProvider {
    static var previews: some View {
        SelectPhotosView()
    }
}

// MARK: - Extensions

fileprivate extension SelectPhotosView {
    // MARK: - Constant enumeration

    enum Constants {
        fileprivate static let imageSize: CGFloat = 20
        fileprivate static let topPadding: CGFloat = 2
		fileprivate static let selectionLimit = 60
    }
}
