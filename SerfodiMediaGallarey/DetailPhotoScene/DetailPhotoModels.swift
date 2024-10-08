//
//  DetailPhotoModels.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 08.09.2024.
//

import UIKit

enum DetailPhoto {
    // MARK: Use cases
    
    enum Something {
        enum Request {
            case getImage
            case openInfo
            case sharedPhoto
            case downloadPhoto
        }
        enum Response {
            case responseMoreInfo
            case responsePhoto(image: UIImage?)
            case responseFullPhoto
            case responseError(Error)
            case responseErrorDownload
            case responseDownloadImage
            case responseLoad
        }
        enum ViewModel {
            case displayShared
            case displayInfo
            case displayImage(image: UIImage)
            case displayError(String)
            case displayErrorDownload
            case displayDownloadImage
            case displayLoad
        }
    }
}
