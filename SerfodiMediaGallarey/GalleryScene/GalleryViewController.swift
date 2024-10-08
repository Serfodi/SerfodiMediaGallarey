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
    
    private var collectionView: GalleryCollectionView
    private let dataSource : MediaDataSource
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
        configurationNavigationItem()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(MediaViewCell.self)
        collectionView.delegate = dataSource
        dataSource.registerFooter(collectionView.createRefreshControl())
        dataSource.selected = { [weak self] in
            self?.selectedCell($0)
        }
        dataSource.didEndCollection = { [weak self] in
            self?.loadNew()
        }
        collectionView.setRefreshControl(self, action: #selector(refresh))
        // setup search bar
        searchView.searchDelegate = self
        navigationItem.title = "Search".localized()
        navigationItem.searchController = searchView
        navigationItem.hidesSearchBarWhenScrolling = false
        self.showFirst()
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    // MARK: Action
    
    @objc func refresh() {
        interactor?.doSomething(request: .refreshPage)
    }
    
    func loadNew() {
        interactor?.doSomething(request: .loadPage)
    }
    
    @objc func changeGrid() {
        interactor?.doSomething(request: .changeGrid)
    }
    
    func changeOrderBy(_ action: UIAction) {
        interactor?.doSomething(request: .orderBy)
    }
    
    func sortedByDate(_ action: UIAction) {
        interactor?.doSomething(request: .sortedValue(.date))
    }
    
    func sortedByLike(_ action: UIAction) {
        interactor?.doSomething(request: .sortedValue(.likes))
    }
    
    func selectedCell(_ mediaId: String) {
        interactor?.doSomething(request: .getPhoto(id: mediaId))
    }
    
    // MARK: Do something
        
    func displaySomething(viewModel: Gallery.Something.ViewModel) {
        self.hideAll()
        
        switch viewModel {
        case .displayMedia(media: let media):
            if media.isEmpty { self.showSearch() }
            reloadData(with: media)
            
        case .displayErrorAlert(let error):
            showAlert(with: "Error".localized(), and: error)
            
            if let stop = collectionView.stopLoading { stop() }
            collectionView.refreshControl?.endRefreshing()
            
        case .displayNewMedia(media: let media):
            if media.isEmpty { self.showSearch() }
            reloadData(with: media)
            if let stop = collectionView.stopLoading { stop() }
            
        case .displayFooterLoader:
            if let start = collectionView.startLoading { start() }
            
        case .displayRefreshMedia(media: let media):
            if media.isEmpty { self.showSearch() }
            reloadData(with: media)
            collectionView.refreshControl?.endRefreshing()
            
        case .displayNewGrid(media: let media, display: let display):
            if media.isEmpty { self.showSearch() }
            collectionView.displayLayout = display
            reloadData(with: media)
            
        case .displaySelectedPhoto:
            router?.routeToDetail()
            
        case .displayLoader:
            self.showLoading()
        case .displayError(let error):
            self.showError(text: error) {
                self.interactor?.doSomething(request: .refreshPage)
            }
        }
    }
    
    // MARK: Helpers
    
    func reloadData(with data: [MediaCellModel]) {
        dataSource.reload(data)
    }
    
    private func configurationNavigationItem() {
        // left item
        navigationItem.leftBarButtonItem = .init(
            image: StaticImage.displayMode,
            "Change the photo grid".localized(),
            self, #selector(changeGrid))
        
        // right item
        let typeSorted = UIMenu(title: "OrderBy".localized(), children: [
            UIAction(title: "Date".localized(), image: StaticImage.dateIcon, handler: sortedByDate),
            UIAction(title: "Popular".localized(), image: StaticImage.popularIcon, handler: sortedByLike)
        ])
        let barButtonMenu = UIMenu(children: [
            UIAction(title: "Sorted".localized(), image: StaticImage.orderBy, handler: changeOrderBy),
            typeSorted
        ])
        navigationItem.rightBarButtonItem = .init(
            image: StaticImage.orderBy,
            "Sorting photos".localized(),
            barButtonMenu)
    }
}

// MARK: SearchDelegate

extension GalleryViewController: SearchDelegate {
    
    func clickedSearch(parameters: Configuration) {
        interactor?.doSomething(request: .search(parameters: parameters))
    }
}

