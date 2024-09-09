//
//  GalleryWorker.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 06.09.2024.
//

import UIKit

class GalleryWorker {
    
    var fetcher: DataFetcher
    
    init() {
        self.fetcher = NetworkDataFetcher(networking: NetworkService())
    }
    
    func getPhotos(parameters: Configuration) async throws -> [Photo]? {
        try await fetcher.getPhotos(parameters: parameters.requestParameters)
    }
}
