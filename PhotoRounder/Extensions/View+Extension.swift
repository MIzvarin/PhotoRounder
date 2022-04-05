//
//  View+Extension.swift
//  PhotoRounder
//
//  Created by Максим Изварин on 21.02.2022.
//

import SwiftUI

extension View {
	@ViewBuilder func hidden(_ isHidden: Bool) -> some View {
		if isHidden {
			self.hidden()
		} else {
			self
		}
	}
}
