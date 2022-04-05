//
//  CroppedPhotos.swift
//  PhotoRounder
//
//  Created by Максим Изварин on 25.02.2022.
//

import SwiftUI

struct CroppedPhotos: View {
	// MARK: - Public properties
	@EnvironmentObject var viewModel: ViewModel
	@Environment(\.presentationMode) var presentationMode

	// MARK: - Init
	init() {
		setupNavBarAppearance()
	}

	var body: some View {
		NavigationView {
			PhotosListView(displayMode: .showCroppedPhotos)
				.frame(maxWidth: .infinity, maxHeight: .infinity)
				.navigationTitle(Labels.croppedPhotos.rawValue)
				.toolbar {
					Button {
						presentationMode.wrappedValue.dismiss()
					} label: {
						Images.backButton.getImage()
							.foregroundColor(.white)
					}
				}
		}
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

struct CroppedPhotos_Previews: PreviewProvider {
	static var previews: some View {
		CroppedPhotos()
			.environmentObject(ViewModel())
	}
}
