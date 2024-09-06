//
//  MediaView.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 06.09.2024.
//

import UIKit

class MediaView: UIView {

    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .center
        imageView.backgroundColor = ColorAppearance.gray
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    let descriptionLabel = UILabel(title: "foo")
    
    var imageAvatar: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .center
        imageView.layer.cornerRadius = 20
        imageView.backgroundColor = ColorAppearance.gray
        return imageView
    }()
    
    let nameLabel = UILabel(title: "foo")
    
    // MARK: init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        layoutConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutConfiguration() {
        [imageView, descriptionLabel, imageAvatar, nameLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: self.rightAnchor),
            imageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1)
        ])
        
        let profileStack = UIStackView(arrangedSubviews: [imageAvatar, nameLabel], axis: .horizontal, spacing: 10)
        let bottomStack = UIStackView(arrangedSubviews: [descriptionLabel, profileStack], axis: .vertical, spacing: 10)
        addSubview(bottomStack)
        
        bottomStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageAvatar.heightAnchor.constraint(equalToConstant: 40),
            imageAvatar.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            bottomStack.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            bottomStack.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5),
            bottomStack.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5),
            bottomStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
    }
    
}
