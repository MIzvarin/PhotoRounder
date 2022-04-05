//
//  UiImage+Extension.swift
//  PhotoRounder
//
//  Created by Максим Изварин on 28.02.2022.
//

import UIKit

extension UIImage {
	/** downsample image for optimize memory usage
	 - parameter targetSize: size for downsampling.
	 Aspect ratio will be saved as original image
	 */
	func downsample(to targetSize: CGSize) -> UIImage? {
		guard
			let imageData = self.pngData(),
			let cgImageSource = CGImageSourceCreateWithData(imageData as CFData, nil)
		else { return nil }

		// Calculate the desired dimension
		let maxDimensionInPixels = max(targetSize.width, targetSize.height)

		// Perform downsampling
		let downsampleOptions = [
			kCGImageSourceCreateThumbnailFromImageAlways: true,
			kCGImageSourceShouldCacheImmediately: true,
			kCGImageSourceCreateThumbnailWithTransform: true,
			kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels
		] as CFDictionary

		guard
			let downsampledImage = CGImageSourceCreateThumbnailAtIndex(cgImageSource, 0, downsampleOptions)
		else { return nil }

		// Return the downsampled image as UIImage
		return UIImage(cgImage: downsampledImage)
	}

	func isLandscape() -> Bool {
		size.width > size.height
	}
}
