//
//  GalleryRouter.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 06.09.2024.
//

import UIKit

@objc protocol GalleryRoutingLogic {
    func routeToDetail()
}

protocol GalleryDataPassing {
  var dataStore: GalleryDataStore? { get }
}

class GalleryRouter: NSObject, GalleryRoutingLogic, GalleryDataPassing {
  weak var viewController: GalleryViewController?
  var dataStore: GalleryDataStore?
  
  // MARK: Routing
  
  func routeToDetail() {
      let destinationVC = DetailPhotoViewController()
      var destinationDS = destinationVC.router!.dataStore!
      passDataToSomewhere(source: dataStore!, destination: &destinationDS)
      navigateToSomewhere(source: viewController!, destination: destinationVC)
  }

    // MARK: Navigation
    
    func navigateToSomewhere(source: GalleryViewController, destination: DetailPhotoViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    
    // MARK: Passing data
    
    func passDataToSomewhere(source: GalleryDataStore, destination: inout DetailPhotoDataStore) {
        destination.photo = source.photo
    }
}
