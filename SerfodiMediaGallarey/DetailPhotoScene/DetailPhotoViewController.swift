//
//  DetailPhotoViewController.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 08.09.2024.
//

import UIKit

protocol DetailPhotoDisplayLogic: AnyObject {
    @MainActor func displaySomething(viewModel: DetailPhoto.Something.ViewModel)
}

class DetailPhotoViewController: UIViewController, DetailPhotoDisplayLogic {
    var interactor: DetailPhotoBusinessLogic?
    var router: (NSObjectProtocol & DetailPhotoRoutingLogic & DetailPhotoDataPassing)?
    
    var scrollView: PhotoScrollView!
    
    override var prefersStatusBarHidden: Bool {
        true
    }
    
    // MARK: Object lifecycle
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        
    // MARK: View lifecycle
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ColorAppearance.black
        scrollView = PhotoScrollView(frame: view.bounds)
        view.addSubview(scrollView)
        NSLayoutConstraint.activate(scrollView.layoutConstraints(in: view))
        interactor?.doSomething(request: .getImage)
        configurationView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: Do something
    
    func displaySomething(viewModel: DetailPhoto.Something.ViewModel) {
        self.hideAll()
        switch viewModel {
        case .displayImage(image: let image):
            scrollView.set(image: image)
        case .displayError(let error):
            showAlert(with: "Error".localized(), and: error) {
                self.navigationController?.popViewController(animated: true)
            }
        case .displayShared:
            router?.routeToShared()
        case .displayInfo:
            router?.routeToDetailInfo()
        case .displayDownloadImage:
            self.showMiniAlert(with: .done)
        case .displayLoad:
            self.showMiniAlert(with: .loader)
        case .displayErrorDownload:
            self.showMiniAlert(with: .error)
        }
    }
    
    // MARK: Action
    
    @objc func closePhoto() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func openInfo() {
        interactor?.doSomething(request: .openInfo)
    }
    
    @objc func sharedImage() {
        interactor?.doSomething(request: .sharedPhoto)
    }
    
    @objc func downloadImage() {
        interactor?.doSomething(request: .downloadPhoto)
    }
    
}

private extension DetailPhotoViewController {
    
    func configurationView() {
        let closeView = button(image: StaticImage.closeIcon, action: #selector(closePhoto))
        let infoView = button(image: StaticImage.infoIcon, action: #selector(openInfo))
        let sharedView = button(image: StaticImage.sharedIcon, action: #selector(sharedImage))
        let downloadView = button(image: StaticImage.downloadIcon, action: #selector(downloadImage))
        
        self.view.addSubview(closeView)
        self.view.addSubview(infoView)
        self.view.addSubview(sharedView)
        self.view.addSubview(downloadView)
        
        closeView.topToSuperview(value: 10, usingSafeArea: true)
        closeView.trailingToSuperview(value: 10, usingSafeArea: true)
        sharedView.topToSuperview(value: 10,  usingSafeArea: true)
        sharedView.leadingToSuperview(value: 10, usingSafeArea: true)
        infoView.bottomToSuperview(value: 10, usingSafeArea: true)
        infoView.trailingToSuperview(value: 10, usingSafeArea: true)
        downloadView.bottomToSuperview(value: 10, usingSafeArea: true)
        downloadView.leadingToSuperview(value: 10, usingSafeArea: true)
    }
    
    func button(image: UIImage?, action: Selector) -> UIView {
        let button = UIButton(type: .system)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: action, for: .touchUpInside)
        let height = StaticImage.SizeIcon.height()
        let view = UIView.blurConfiguration(addView: button, height: height)
        view.height(height)
        view.aspectRatio(1)
        return view
    }
    
}
