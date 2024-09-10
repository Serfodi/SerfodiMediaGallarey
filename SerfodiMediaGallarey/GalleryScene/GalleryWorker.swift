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
    
    func getPhotos(parameters: Configuration) async throws -> [Photo] {
        self.configuration = parameters
        let data = try await fetcher.getPhotos(parameters: parameters.requestParameters)
        guard let data = data else { throw DataError.notData  }
        return data
    }
    
    func getFirstPage() async throws -> [Photo] {
        guard configuration != nil else { return [] }
        self.configuration?.page = 1
        let data = try await fetcher.getPhotos(parameters: configuration!.requestParameters)
        guard let data = data else { throw DataError.notData  }
        return data
    }
    
    func getNewPhotos() async throws -> [Photo] {
        guard configuration != nil else { return [] }
        self.configuration?.page += 1
        let data = try await fetcher.getPhotos(parameters: configuration!.requestParameters)
        guard let data = data else { throw DataError.notData  }
        return data
    }
    
}
