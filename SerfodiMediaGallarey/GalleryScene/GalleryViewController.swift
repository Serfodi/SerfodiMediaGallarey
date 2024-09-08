//
//  GalleryViewController.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 06.09.2024.
//

import UIKit

protocol GalleryDisplayLogic: AnyObject {
    @MainActor func displaySomething(viewModel: Gallery.Something.ViewModel)
}

class GalleryViewController: UIViewController, GalleryDisplayLogic {
    
    var interactor: GalleryBusinessLogic?
    var router: (NSObjectProtocol & GalleryRoutingLogic & GalleryDataPassing)?
    
    let collectionView: GalleryCollectionView
    let dataSource : MediaDataSource
    private let searchView: SearchViewController
    
    // MARK: Object lifecycle
    
    init() {
        self.collectionView = GalleryCollectionView()
        self.dataSource = MediaDataSource(collectionView)
        self.searchView = SearchViewController()
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = GalleryInteractor()
        let presenter = GalleryPresenter()
        let router = GalleryRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: View lifecycle
    
    override func loadView() {
        super.loadView()
        view.addSubview(collectionView)
        NSLayoutConstraint.activate(collectionView.layoutConstraints(in: view))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(MediaViewCell.self)
        collectionView.delegate = dataSource
        // setup search bar
        searchView.searchDelegate = self
        navigationItem.title = "Search".localized()
        navigationItem.searchController = searchView
        navigationItem.hidesSearchBarWhenScrolling = false
    }
        
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    // MARK: Do something
        
    func displaySomething(viewModel: Gallery.Something.ViewModel) {
        switch viewModel {
        case .displayMedia(items: let items):
            reloadData(with: items)
        case .displayError(let error):
            showAlert(with: "Error".localized(), and: error)
        }
    }
    
    // MARK: Helpers
    
    func reloadData(with data: [MediaCellModel]) {
        dataSource.reload(data)
    }
    
}

// MARK: SearchDelegate

extension GalleryViewController: SearchDelegate {
    
    func clickedSearch(parameters: Configuration) {
        interactor?.doSomething(request: .search(parameters: parameters))
    }
}

