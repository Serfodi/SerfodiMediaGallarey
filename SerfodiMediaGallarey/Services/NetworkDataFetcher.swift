//
//  NetworkDataFetcher.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 06.09.2024.
//

import Foundation

protocol DataFetcher {
    func getPhotos(parameters:[String:String]) async throws -> [Photo]?
    func getPhotoInfo(id: String) async throws -> Photo?
}

class NetworkDataFetcher: DataFetcher {
    
    let networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
    }
    
    /// Photo Search request Get
    ///
    /// - Invariant: endpoint `API.photosPath = /search/photos`
    ///
    /// Parameters:
    ///  * query – Search terms
    ///  * page – Page number to retrieve. (Optional; default: 1)
    ///  * per_page – Number of items per page. (Optional; default: 10)
    ///
    /// - seealso: Find more information for [Unsplash Developers](https://unsplash.com/documentation#search-photos)
    ///
    func getPhotos(parameters: [String : String]) async throws -> [Photo]? {
        let data = try await networking.request(path: API.photosPath, params: parameters)
        let decoded = self.decoderJSON(type: ResponseWrapped<Photo>.self, from: data)
        return decoded?.results
    }
    
    /// Get info photo witch `id`
    ///
    /// This method gives you more information about the Photo. \
    /// For example: location, camera, tags.
    ///
    /// - Invariant: endpoint `API.photos = /photos`
    /// - seealso: Find more information for [Unsplash Developers](https://unsplash.com/documentation#get-a-photo)
    ///
    func getPhotoInfo(id: String) async throws -> Photo? {
        let data = try await networking.request(path: API.photos + id, params: [:])
        let decoded = self.decoderJSON(type: Photo.self, from: data)
        return decoded
    }
    
    private func decoderJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard
            let data = from,
            let response = try? decoder.decode(type.self, from: data)
        else { return nil }
        return response
    }
    
}
