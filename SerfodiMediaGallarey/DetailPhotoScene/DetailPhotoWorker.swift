//
//  DetailPhotoWorker.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 08.09.2024.
//

import UIKit
import Photos

class DetailPhotoWorker {
    
    let download = DownloadImage()
    var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
    
    func loadImage(urlString: String?)  async throws -> UIImage? {
        guard let url = URL(string: urlString ?? "") else { return nil }
        return try await download.load(url: url)
    }
    
    func loadInfo(id: String)  async throws -> Photo? {
        try await fetcher.getPhotoInfo(id: id)
    }
    
    func downloadImage(_ image: UIImage) async throws {
        try await PHPhotoLibrary.shared().performChanges {
            let request = PHAssetChangeRequest.creationRequestForAsset(from: image)
        }
    }
        
}
