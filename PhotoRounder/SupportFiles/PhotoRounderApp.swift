//
//  PhotoRounderApp.swift
//  PhotoRounder
//
//  Created by Максим Изварин on 10.02.2022.
//

import SwiftUI

@main
struct PhotoRounderApp: App {
    @StateObject private var viewModel = ViewModel()

    var body: some Scene {
        WindowGroup {
            SelectPhotosView()
                .environmentObject(viewModel)
        }
    }
}
