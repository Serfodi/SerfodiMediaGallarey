//
//  DownloadImage.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 08.09.2024.
//

import UIKit

class DownloadImage {
    
    private var currentUrlString: URL?
    
    /// Download async image witch URL
    func load(url: URL) async throws -> UIImage? {
        currentUrlString = url
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            return UIImage(data: cachedResponse.data)
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        return self.handleLoadedImage(data: data, response: response)
    }
    
    private func handleLoadedImage(data: Data, response: URLResponse) -> UIImage? {
        guard let responseURL = response.url else { return nil }
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseURL))
        if responseURL == currentUrlString {
            return UIImage(data: data)!.preloadedImage()
        }
        return nil
    }
    
}
