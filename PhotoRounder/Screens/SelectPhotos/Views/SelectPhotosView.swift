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

    @EnvironmentObject var viewModel: SelectPhotosViewModel

    // MARK: - Private properties

    @State private var showPhotoLibrary = false
    @State private var isPhotosHandling = false
    private let pickerConfiguration: PHPickerConfiguration = {
        var configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        configuration.filter = .images
        configuration.selectionLimit = Constants.selectionLimit
        return configuration
    }()
    private var isActionButtonDisabled: Bool {
        viewModel.photos.isEmpty || isPhotosHandling
    }

    // MARK: - Init

    init() {
        setupNavBarAppearance()
    }

    // MARK: - Body

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    // Selected photos list
                    PhotosListView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    // Auto handling photos button
                    Button {
                        isPhotosHandling.toggle()
                        viewModel.croppPhotos {
                            isPhotosHandling.toggle()
                        }
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
                }.padding([.top], Constants.topPadding)
                // Progressive view
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Colors.magic.getColor()))
                    .scaleEffect(Constants.progressViewScaleEffect)
                    .hidden(!isPhotosHandling)
            }.navigationTitle(Labels.selectedPhotos.rawValue)

            // Navigation toolbar
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
                    }.disabled(isPhotosHandling)
                })
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
        static let imageSize: CGFloat = 20
        static let topPadding: CGFloat = 2
        static let selectionLimit = 60
        static let progressViewScaleEffect: CGFloat = 2
    }
}
