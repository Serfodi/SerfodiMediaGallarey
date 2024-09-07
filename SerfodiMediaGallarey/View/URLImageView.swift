//
//  URLImageView.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 07.09.2024.
//

import UIKit

class WebImageView: UIImageView {
    
    private var currentUrlString: URL?
    
    private var downloadTask: Task<(), any Error>?
    
    /// Download async image witch URL
    func set(url: URL) {
        currentUrlString = url
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            self.image = UIImage(data: cachedResponse.data); return
        }
        downloadTask = Task {
            do {
                let (data, response) = try await URLSession.shared.data(from: url)
                self.handleLoadedImage(data: data, response: response)
            }
        }
    }
    
    private func handleLoadedImage(data: Data, response: URLResponse) {
        guard let responseURL = response.url else { return }
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseURL))
        if responseURL == currentUrlString {
            self.image = UIImage(data: data)!.preloadedImage()
        }
    }
    
    open func cancelDownload() {
        if let task = downloadTask, !task.isCancelled {
            task.cancel()
        }
    }
    
}

