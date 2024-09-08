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
    
    // Data
    var sorted: MediaCellModel.ValueSort = .likes
    var order: Bool = true
    var display: GalleryCollectionView.DisplayLayout = .two // default value
    
    // class
    var calculate: CalculateCellSize!
    
    // MARK: Do something
    
    func presentSomething(response: Gallery.Something.Response) {
        switch response {
        case .responseMedia(media: let media):
            let items = prepareMedia(media)
            Task {
                await viewController?.displaySomething(viewModel: .displayMedia(items: items, display: display))
            }
        case .responseError(let error):
            Task {
                await viewController?.displaySomething(viewModel: .displayError(error.localizedDescription))
            }
        case .responseChangeGrid(media: let media):
            switch display {
            case .one:
                display = .two
            case .two:
                display = .one
            }
            let items = prepareMedia(media)
            Task {
                await viewController?.displaySomething(viewModel: .displayMedia(items: items, display: display))
            }
        case .responseOrderBy(media: let media):
            self.order.toggle()
            let items = prepareMedia(media)
            Task {
                await viewController?.displaySomething(viewModel: .displayMedia(items: items, display: display))
            }
        case .responseSortedValue(media: let media, sortedValue: let sortedValue):
            self.sorted = sortedValue
            let items = prepareMedia(media)
            Task {
                await viewController?.displaySomething(viewModel: .displayMedia(items: items, display: display))
            }
        }
    }
    
    func prepareMedia(_ media: [Photo]) -> [MediaCellModel] {
        calculate = CalculateCellSize(numberRow: display.rawValue)
        var items = media.map { convert(from: $0) }
        sorted(&items)
        return items
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
    
    func sorted(_ items: inout [MediaCellModel]) {
        items.sort { lhs, rhs in
            switch sorted {
            case .likes:
                order ? lhs.like > rhs.like : lhs.like < rhs.like
            case .date:
                order ? lhs.data > rhs.data : lhs.data < rhs.data
            }
        }
    }
    
}
