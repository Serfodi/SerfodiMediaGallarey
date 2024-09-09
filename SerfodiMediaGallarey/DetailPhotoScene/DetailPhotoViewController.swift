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
    var closeButton = UIButton(configuration: .icons(StaticImage.closeIcon))
    var infoButton = UIButton(configuration: .icons(StaticImage.infoIcon))
    var sharedButton = UIButton(configuration: .icons(StaticImage.sharedIcon))
    
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
        configuration()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: Do something
    
    func displaySomething(viewModel: DetailPhoto.Something.ViewModel) {
        switch viewModel {
        case .displayImage(image: let image):
            scrollView.set(image: image)
        case .displayError(let error):
            showAlert(with: "Error".localized(), and: error)
        case .displayShared:
            router?.routeToShared()
        case .displayInfo:
            router?.routeToDetailInfo()
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
}

extension DetailPhotoViewController {
    
    func configuration() {
        closeButton.addTarget(self, action: #selector(closePhoto), for: .touchUpInside)
        infoButton.addTarget(self, action: #selector(openInfo), for: .touchUpInside)
        sharedButton.addTarget(self, action: #selector(sharedImage), for: .touchUpInside)
        view.addSubview(closeButton)
        view.addSubview(infoButton)
        view.addSubview(sharedButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        infoButton.translatesAutoresizingMaskIntoConstraints = false
        sharedButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        sharedButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        sharedButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        infoButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        infoButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
    }
    
}
