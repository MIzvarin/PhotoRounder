//
//  CGRect+Extension.swift
//  PhotoRounder
//
//  Created by Максим Изварин on 18.02.2022.
//

import CoreGraphics

extension CGRect {
	/** Creates a rectangle with the given center and dimensions
	 - parameter center: The center of the new rectangle
	 - parameter size: The dimensions of the new rectangle
	 */
	init(center: CGPoint, size: CGSize) {
		self.init(
			x: center.x - size.width / 2,
			y: center.y - size.height / 2,
			width: size.width,
			height: size.height)
	}
}
