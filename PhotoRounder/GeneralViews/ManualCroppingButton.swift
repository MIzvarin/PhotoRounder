//
//  ManualCroppingButton.swift
//  PhotoRounder
//
//  Created by Максим Изварин on 02.03.2022.
//

import SwiftUI

struct ManualCroppingButton: View {
	// MARK: - Public properties
	
	let action: () -> Void
	
	// MARK: - Private properties
	
	private let imageSize: CGFloat = 35
	
	// MARK: - Body
	
    var body: some View {
		Button {
			action()
		} label: {
			Image(systemName: Images.scissors.rawValue)
				.resizable()
				.frame(width: imageSize, height: imageSize)
				.foregroundColor(Colors.main.getColor())
		}

    }
}

struct ManualCroppingButton_Previews: PreviewProvider {
    static var previews: some View {
		ManualCroppingButton {
			
		}
    }
}
