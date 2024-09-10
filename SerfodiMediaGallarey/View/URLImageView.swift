//
//  URLImageView.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 07.09.2024.
//

import UIKit

class WebImageView: UIImageView {
    
    private var downloadTask: Task<(), any Error>?
    private let cache = ImageCache.cache
    
    /// Download async image witch URL
    func asyncSetImage(url: URL) {
        downloadTask = Task(priority: .high) {
            let image = try? await DownloadImage().load(url: url)
            self.image = image
        }
    }
    
    func cancelDownload() {
        downloadTask?.cancel()
    }
    
}

