//
//  GalleryRouter.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 06.09.2024.
//

import UIKit

@objc protocol GalleryRoutingLogic {
//  func routeToSomewhere(navigateTo: UIViewController)
}

protocol GalleryDataPassing {
  var dataStore: GalleryDataStore? { get }
}

class GalleryRouter: NSObject, GalleryRoutingLogic, GalleryDataPassing {
  weak var viewController: GalleryViewController?
  var dataStore: GalleryDataStore?
  
  // MARK: Routing
  
  //func routeToSomewhere(navigateTo: UIViewController) {}

  // MARK: Navigation
  
  //func navigateToSomewhere(source: GalleryViewController, destination: SomewhereViewController) {
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: GalleryDataStore, destination: inout SomewhereDataStore) {
  //  destination.name = source.name
  //}
}
