//
//  GalleryPresenter.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 06.09.2024.
//

import UIKit

protocol GalleryPresentationLogic {
    func presentSomething(response: Gallery.Something.Response)
}

class GalleryPresenter: GalleryPresentationLogic {
    
    weak var viewController: GalleryDisplayLogic?
    
    var calculate: CalculateCellSize!
    
    struct PhotoCellModel: PhotoSizeModel {
        var width: Int
        var height: Int
    }
    
    // MARK: Do something
    
    func presentSomething(response: Gallery.Something.Response) {
        switch response {
        case .presentMediaItems(media: let media, display: let display):
            // calculate size cell
            calculate = CalculateCellSize(numberRow: display.rawValue)
            // convert Photo -> MediaCellModel
            let cellModel = media.map { convert(from: $0) }
            Task {
                await viewController?.displaySomething(viewModel: .displayMedia(items: cellModel, display: display))
            }
        case .responseError(let error):
            Task {
                await viewController?.displaySomething(viewModel: .displayError(error.localizedDescription))
            }
        }
    }
        
    func convert(from photo: Photo) -> MediaCellModel {
        let size = calculate.sizes(description: photo.description, photo: PhotoCellModel(width: photo.width, height: photo.height))
        return MediaCellModel(id: photo.id,
              imageURL: photo.urls.regular,
              description: photo.description,
              imageAvatar: photo.user.profileImage.small,
              name: photo.user.username,
                              size: size,
                              data: photo.createdAt,
                              like: photo.likes)
    }
    
}
