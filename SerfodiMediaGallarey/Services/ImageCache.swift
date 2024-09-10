//
//  ImageCache.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 10.09.2024.
//

import UIKit

class ImageCache {

    static let cache: URLCache = {
        let diskPath = "SerfodiMediaGallarey"
        let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let cacheURL = cachesDirectory.appendingPathComponent(diskPath, isDirectory: true)
        return URLCache(
            memoryCapacity: ImageCache.memoryCapacity,
            diskCapacity: ImageCache.diskCapacity,
            directory: cacheURL
        )
    }()

    static let memoryCapacity: Int = 50.megabytes
    static let diskCapacity: Int = 100.megabytes

}

private extension Int {
    var megabytes: Int { return self * 1024 * 1024 }
}
