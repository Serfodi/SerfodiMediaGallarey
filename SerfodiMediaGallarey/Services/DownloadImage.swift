//
//  DownloadImage.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 08.09.2024.
//

import UIKit

class DownloadImage {
    
    private let cache = ImageCache.cache
    
    /// Download async image witch URL
    func load(url: URL) async throws -> UIImage? {
        
        if let cachedResponse = cache.cachedResponse(for: URLRequest(url: url)) {
            return UIImage(data: cachedResponse.data)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let responseURL = response.url, let image = UIImage(data: data) else { return nil }
        
        let cachedResponse = CachedURLResponse(response: response, data: data)
        self.cache.storeCachedResponse(cachedResponse, for: URLRequest(url: url))
        
        return image
    }
        
}
