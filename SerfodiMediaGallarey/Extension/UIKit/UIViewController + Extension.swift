//
//  UIViewController + Extension.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 06.09.2024.
//

import UIKit

extension UIViewController {
    
    func showAlert(with title: String, and message: String, completion: @escaping () -> Void = {} ) {
        let alertController = UIAlertController(title: NSLocalizedString(title, comment: ""), message: NSLocalizedString(message, comment: ""), preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            completion()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
    func showMiniAlert(with state: MiniAlert.State) {
        let alert = MiniAlert(state: state)
        self.view.addSubview(alert)
        NSLayoutConstraint.activate(alert.layoutConstraints(in: self.view))
        alert.showAlert()
    }
    
}

extension UIViewController {
    
    func hideAll() {
        contentUnavailableConfiguration = nil
    }
    
    func showFirst() {
        var firstConfig = UIContentUnavailableConfiguration.empty()
        firstConfig.image = StaticImage.imageStar
        firstConfig.text = "Start the search".localized()
        firstConfig.secondaryText = "Look for photos and get inspired".localized()
        contentUnavailableConfiguration = firstConfig
    }
    
    func showSearch() {
        contentUnavailableConfiguration = UIContentUnavailableConfiguration.search()
    }
    
    func showLoading() {
        var config = UIContentUnavailableConfiguration.loading()
        config.text = "Download".localized()
        contentUnavailableConfiguration = config
    }
    
    /// Show the empty state when encounter error
    func showError(text: String, repeatAction: @escaping () -> ()) {
        var errorConfig = UIContentUnavailableConfiguration.empty()
        errorConfig.image = StaticImage.errorIcon
        errorConfig.text = "Error".localized()
        errorConfig.secondaryText = "\(text)\n\("Please try again".localized())"
        
        var retryButtonConfig = UIButton.Configuration.borderless()
        retryButtonConfig.image = StaticImage.tryAgain
        errorConfig.button = retryButtonConfig
        
        errorConfig.buttonProperties.primaryAction = UIAction.init(handler: { _ in
            repeatAction()
        })
        
        contentUnavailableConfiguration = errorConfig
    }
    
}
