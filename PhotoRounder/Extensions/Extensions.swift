//
//  Extensions.swift
//  PhotoRounder
//
//  Created by Максим Изварин on 17.02.2022.
//

import CoreGraphics

//MARK: - CGRect

extension CGRect {
	
	// Init for creation square CGRect using center point and side size
	
	init(center: CGPoint, sideSize: CGFloat) {
		self.init(x: center.x - sideSize / 2, y: center.y - sideSize / 2, width: sideSize, height: sideSize)
	}
}
