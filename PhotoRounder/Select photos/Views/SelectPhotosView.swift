//
//  SelectPhotosView.swift
//  PhotoRounder
//
//  Created by Максим Изварин on 10.02.2022.
//

import SwiftUI
import PhotosUI

struct SelectPhotosView: View {
    
    //MARK: - Public properties
    
    @ObservedObject private var viewModel = SelectPhotosViewModel()
    
    //MARK: - Private properties
    
    //State
    @State private var showPhotoLibrary = false
    
    //constant
    private let imageSize: CGFloat = 20
    private let padding: CGFloat = 20
    private let topPadding: CGFloat = 2
    private let pickerConfiguration: PHPickerConfiguration = {
        var configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        configuration.filter = .images
        configuration.selectionLimit = 60
        return configuration
    }()
    
    //computed
    private var isActionButtomDisabled: Bool {
        viewModel.selectedPhotos.isEmpty
    }
    
    //MARK: - Init
    
    init() {
        setupNavBarAppearance()
    }
    
    //MARK: - Body
    
    var body: some View {
        NavigationView {
            VStack() {
                //Selected photos list
                PhotosListView(selectedPhotos: $viewModel.selectedPhotos)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                Button {
                    print("123")
                } label: {
                    HStack {
                        Images.magic.getImage()
                            .resizable()
                            .frame(width: imageSize, height: imageSize)
                        
                        Text(Labels.magic.rawValue)
                            .foregroundColor(isActionButtomDisabled ? Colors.helperText.getColor() : Colors.magic.getColor())
                    }
                }.padding()
                    .disabled(isActionButtomDisabled)
            }.navigationTitle(Labels.selectedPhotos.rawValue)
                .toolbar(content: {
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
                .padding([.top], topPadding)
        }.navigationViewStyle(.stack)
    }
    
    //MARK: - Private functions
    
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

//MARK: - Preview

struct SelectPhotosView_Previews: PreviewProvider {
    static var previews: some View {
        SelectPhotosView()
            .previewDevice("iPhone 13 Pro")
    }
}
