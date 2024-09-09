//
//  GalleryWorker.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 06.09.2024.
//

import UIKit

class GalleryWorker {
    
    var fetcher: DataFetcher
    
    private var configuration: Configuration?
    
    init() {
        self.fetcher = NetworkDataFetcher(networking: NetworkService())
    }
    
    func getPhotos(parameters: Configuration) async throws -> [Photo]? {
        self.configuration = parameters
        return try await fetcher.getPhotos(parameters: parameters.requestParameters)
    }
    
    func getNewPhotos() async throws -> [Photo]? {
        guard configuration != nil else { return nil }
        self.configuration?.page += 1
        return try await fetcher.getPhotos(parameters: configuration!.requestParameters)
    }
    
}
