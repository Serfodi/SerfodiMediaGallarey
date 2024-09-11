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
    
    // Data View
    var sorted: MediaCellModel.ValueSort? = nil
    var order: Bool = true
    var display: GalleryCollectionView.DisplayLayout = .two
    
    // class
    var calculate: CalculateCellSize!
    
    // MARK: Do something
    
    func presentSomething(response: Gallery.Something.Response) {
        switch response {
        case .presentPhotos(photos: let photos):
            let items = prepareMedia(photos)
            Task {
                await viewController?.displaySomething(viewModel: .displayMedia(media: items))
            }
            
        case .presentErrorAlert(let error):
            Task {
                await viewController?.displaySomething(viewModel: .displayErrorAlert(error.localizedDescription))
            }
            
        case .presentNewPhotos(photos: let photos):
            sorted = nil
            let items = prepareMedia(photos)
            Task {
                await viewController?.displaySomething(viewModel: .displayNewMedia(media: items))
            }
            
        case .presentFooterLoader:
            Task {
                await viewController?.displaySomething(viewModel: .displayFooterLoader)
            }
            
        case .presentRefreshPhotos(photos: let photos):
            let items = prepareMedia(photos)
            Task {
                await viewController?.displaySomething(viewModel: .displayRefreshMedia(media: items))
            }
            
        case .presentChangeGrid(photos: let photos):
            self.display.toggle()
            let items = prepareMedia(photos)
            Task {
                await viewController?.displaySomething(viewModel: .displayNewGrid(media: items, display: display))
            }
            
        case .presentOrderBy(photos: let photos):
            self.order.toggle()
            let items = prepareMedia(photos)
            Task {
                await viewController?.displaySomething(viewModel: .displayMedia(media: items))
            }
            
        case .presentSortedValue(photos: let photos, sortedValue: let sortedValue):
            self.sorted = sortedValue
            let items = prepareMedia(photos)
            Task {
                await viewController?.displaySomething(viewModel: .displayMedia(media: items))
            }
            
        case .presentSelectedPhoto:
            Task {
                await viewController?.displaySomething(viewModel: .displaySelectedPhoto)
            }
        case .presentError(let error):
            Task {
                await viewController?.displaySomething(viewModel: .displayError(error.localizedDescription))
            }
            
        case .presentLoader:
            Task {
                await viewController?.displaySomething(viewModel: .displayLoader)
            }
        }
    }
    
    
    func prepareMedia(_ media: [Photo]?) -> [MediaCellModel] {
        guard let media = media else { return [] }
        calculate = CalculateCellSize(numberRow: display.rawValue)
        var items = media.map { convert(from: $0) }
        sorted(&items)
        return items
    }
    
    func convert(from photo: Photo) -> MediaCellModel {
        let size = calculate.sizes(description: photo.description, photo: PhotoCellModel(width: photo.width, height: photo.height))
        
        let photoUrlString: String = photo.urls.small
        
        return MediaCellModel(id: photo.id,
                              imageURL: photoUrlString,
                              description: photo.description,
                              user: photo.user,
                              size: size,
                              date: photo.createdAt ?? Date(),
                              like: photo.likes)
    }
    
    func sorted(_ items: inout [MediaCellModel]) {
        guard let sorted = sorted else { return }
        items.sort { lhs, rhs in
            switch sorted {
            case .likes:
                return order ? lhs.like > rhs.like  : lhs.like < rhs.like
            case .date:
                return order ? lhs.date > rhs.date : lhs.date < rhs.date
            }
        }
    }
}
