//
//  DetailPhotoViewController.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 08.09.2024.
//

import UIKit

protocol DetailPhotoDisplayLogic: AnyObject {
    func displaySomething(viewModel: DetailPhoto.Something.ViewModel)
}

class DetailPhotoViewController: UIViewController, DetailPhotoDisplayLogic {
    var interactor: DetailPhotoBusinessLogic?
    var router: (NSObjectProtocol & DetailPhotoRoutingLogic & DetailPhotoDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = DetailPhotoInteractor()
        let presenter = DetailPhotoPresenter()
        let router = DetailPhotoRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: Do something
    
    func displaySomething(viewModel: DetailPhoto.Something.ViewModel) {
        
    }
    
}
