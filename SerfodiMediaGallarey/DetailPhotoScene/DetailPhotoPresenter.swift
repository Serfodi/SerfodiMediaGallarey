//
//  DetailPhotoPresenter.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 08.09.2024.
//
import UIKit

protocol DetailPhotoPresentationLogic {
    func presentSomething(response: DetailPhoto.Something.Response)
}

class DetailPhotoPresenter: DetailPhotoPresentationLogic {
    
    weak var viewController: DetailPhotoDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(response: DetailPhoto.Something.Response) {
        switch response {
        case .responsePhoto(image: let image):
            Task {
                await viewController?.displaySomething(viewModel: .displayImage(image: image ?? UIImage()))
            }
        case .responseError(let error):
            Task {
                await viewController?.displaySomething(viewModel: .displayError(error.localizedDescription))
            }
        case .responseMoreInfo:
            Task {
                await viewController?.displaySomething(viewModel: .displayInfo)
            }
        case .responseFullPhoto:
            Task {
                await viewController?.displaySomething(viewModel: .displayShared)
            }
        case .responseDownloadImage:
            Task {
                await viewController?.displaySomething(viewModel: .displayDownloadImage)
            }
        case .responseLoad:
            Task {
                await viewController?.displaySomething(viewModel: .displayLoad)
            }
        case .responseErrorDownload:
            Task {
                await viewController?.displaySomething(viewModel: .displayErrorDownload)
            }
        }
    }
}
