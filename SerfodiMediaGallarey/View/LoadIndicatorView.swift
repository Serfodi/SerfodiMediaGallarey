//
//  LoadIndicatorView.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 09.09.2024.
//

import UIKit

class LoadIndicatorView: UICollectionReusableView {
    
    private var loaderView: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.hidesWhenStopped = true
        return loader
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(loaderView)
        loaderView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loaderView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        loaderView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    func showLoader() {
        loaderView.startAnimating()
    }
    
    func hideLoader() {
        loaderView.stopAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
