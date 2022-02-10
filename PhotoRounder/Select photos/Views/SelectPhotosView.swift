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
    private let photoImage = Image(systemName: ImageNames.photo.rawValue)
    private let magicImage = Image(uiImage: UIImage(named: ImageNames.magic.rawValue)!)
    private let scissorsImage = Image(systemName: ImageNames.handmade.rawValue)
    private let pickerConfiguration: PHPickerConfiguration = {
        var config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        config.filter = .images
        config.selectionLimit = 60
        return config
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
                Spacer()
                
                //Selected photos list
                PhotosListView(selectedPhotos: $viewModel.selectedPhotos)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                Spacer()
                
                //Select photos button
                ActionButton(text: Labels.selectPhotos.rawValue,
                             image: photoImage) {
                    showPhotoLibrary = true
                }.foregroundColor(Colors.main.getColor())
                    .padding([.bottom], 20)
                    .sheet(isPresented: $showPhotoLibrary) {
                        
                        //Call image picker
                        ImagePickerView(configuration: pickerConfiguration) { selectedImage in
                            viewModel.selectedPhotos.append(selectedImage)
                        }
                    }
                
                HStack {
                    //Manual handling button
                    ActionButton(text: Labels.handmade.rawValue,
                                 image: scissorsImage) {
                        print("312")
                    }.foregroundColor(isActionButtomDisabled ? .gray : Colors.main.getColor())
                        .disabled(isActionButtomDisabled)
                    
                    Spacer()
                    
                    //Auto handling button
                    ActionButton(text: Labels.magic.rawValue,
                                 image: magicImage) {
                        print("123")
                    }.foregroundColor(isActionButtomDisabled ? .gray : Colors.magic.getColor())
                        .disabled(isActionButtomDisabled)
                }
            }.navigationTitle(Labels.selectedPhotos.rawValue)
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
