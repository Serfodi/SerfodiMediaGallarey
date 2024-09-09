//
//  GalleryModels.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 06.09.2024.
//

import UIKit

enum Gallery {
    // MARK: Use cases
    
    enum Something {
        enum Request {
            case search(parameters: Configuration)
            case changeGrid
            case orderBy
            case sortedValue(MediaCellModel.ValueSort)
            case getPhoto(id: String)
        }
        enum Response {
            case responseChangeGrid(media:[Photo]?)
            case responseOrderBy(media:[Photo]?)
            case responseSortedValue(media:[Photo]?, sortedValue: MediaCellModel.ValueSort)
            
            case responseMediaItem
            case responseMedia(media:[Photo]?)
            case responseError(Error)
        }
        enum ViewModel {
            case displayMedia(items:[MediaCellModel], display: GalleryCollectionView.DisplayLayout)
            case displayError(String)
            case displayPhoto
        }
    }
}
// , display: GalleryCollectionView.DisplayLayout
