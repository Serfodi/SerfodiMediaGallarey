//
//  DetailPhotoRouter.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 08.09.2024.
//

import UIKit

@objc protocol DetailPhotoRoutingLogic {
    func routeToDetailInfo()
    func routeToShared()
}

protocol DetailPhotoDataPassing {
    var dataStore: DetailPhotoDataStore? { get }
}

class DetailPhotoRouter: NSObject, DetailPhotoRoutingLogic, DetailPhotoDataPassing {
    
    weak var viewController: DetailPhotoViewController?
    var dataStore: DetailPhotoDataStore?
    
    // MARK: Routing
    
    func routeToDetailInfo() {
        let destinationVC = DetailInfoViewController(photo: dataStore!.photo)
        navigateToDetailInfo(source: viewController!, destination: destinationVC)
    }
    
    func routeToShared() {
        let vc = UIActivityViewController(activityItems: [dataStore!.fullImage!], applicationActivities: [])
        navigateToShared(source: viewController!, destination: vc)
    }
    
    // MARK: Navigation
    
    func navigateToDetailInfo(source: DetailPhotoViewController, destination: UIViewController) {
        destination.modalPresentationStyle = .pageSheet
        let sheet = destination.sheetPresentationController
        sheet?.detents = [.medium()]
        source.present(destination, animated: true)
    }
    
    func navigateToShared(source: DetailPhotoViewController, destination: UIActivityViewController) {
        source.present(destination, animated: true)
    }
    
}
