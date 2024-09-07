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
    
    // MARK: Do something
    
    func presentSomething(response: Gallery.Something.Response) {
        switch response {
        case .presentMediaItems(media: let media):
            print(media)
            let cellModel = media.map { convert(from: $0) }
            print(cellModel)
            Task {
                await viewController?.displaySomething(viewModel: .displayMedia(items: cellModel))
            }
        case .responseError(let error):
            Task {
                await viewController?.displaySomething(viewModel: .displayError(error.localizedDescription))
            }
        }
    }
    
//    func convert(from photo: Photo) -> MediaCellModel {
//        .init(id: photo.id,
//              imageURL: photo.urls?.regular ?? "",
//              description: photo.description ?? "",
//              imageAvatar: photo.user?.profileImage?.small ?? "",
//              name: photo.user?.username ?? "")
//    }
    
    func convert(from photo: Photo) -> MediaCellModel {
        .init(id: photo.id,
              imageURL: photo.urls.regular ?? "",
              description: photo.description ?? "",
              imageAvatar: photo.user.profileImage?.small ?? "",
              name: photo.user.username)
    }
    
}
