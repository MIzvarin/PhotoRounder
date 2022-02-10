//
//  SelectPhotosView.swift
//  PhotoRounder
//
//  Created by Максим Изварин on 10.02.2022.
//

import SwiftUI

struct SelectPhotosView: View {
    //MARK: - Private properties
    
    private let imageName = "photo"
    private let interfaceColor = UIColor.blue.withAlphaComponent(0.75)
    
    //MARK: - Init
    
    init() {
        setupNavBarAppearance()
    }
    
    //MARK: - Body
    
    var body: some View {
        NavigationView {
            VStack() {
                Spacer()
                
                Button {
                    print(Labels.selectPhotos.rawValue)
                } label: {
                    HStack {
                        Image(systemName: imageName)
                        Text(Labels.selectPhotos.rawValue)
                    }.frame(width: 200, height: 40)
                        .overlay(RoundedRectangle(cornerRadius: 15)
                                    .stroke(lineWidth: 2))
                }.foregroundColor(Color(uiColor: interfaceColor))
                    .padding([.bottom], 50)
            }.navigationTitle(Labels.selectPhotos.rawValue)
        }
    }
    
    //MARK: - Private functions
    
    private func setupNavBarAppearance() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = interfaceColor
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
