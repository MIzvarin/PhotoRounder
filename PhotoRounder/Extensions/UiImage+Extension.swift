//
//  UiImage+Extension.swift
//  PhotoRounder
//
//  Created by Максим Изварин on 28.02.2022.
//

import UIKit

extension UIImage {
    func downsample() -> UIImage? {
        guard
            let imageData = self.pngData(),
            let cgImageSource = CGImageSourceCreateWithData(imageData as CFData, nil)
        else { return nil }

        // Calculate the desired dimension
        let maxDimensionInPixels = max(size.width, size.height)

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
}
