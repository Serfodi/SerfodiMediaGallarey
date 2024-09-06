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
        }
        enum Response {
            case presentMediaItems(media:[Photo])
            case responseError(Error)
        }
        enum ViewModel {
            case displayMedia(items:[MediaCellModel])
            case displayError(String)
        }
    }
}
