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
            case changeGrid(display: GalleryCollectionView.DisplayLayout)
        }
        enum Response {
            case presentMediaItems(media:[Photo], display: GalleryCollectionView.DisplayLayout = .two)
            case responseError(Error)
        }
        enum ViewModel {
            case displayMedia(items:[MediaCellModel], display: GalleryCollectionView.DisplayLayout)
            case displayError(String)
        }
    }
}
