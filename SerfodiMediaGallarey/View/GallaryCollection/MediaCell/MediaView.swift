//
//  MediaView.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 06.09.2024.
//

import UIKit

class MediaView: UIView {

    var imageView: WebImageView = {
        let imageView = WebImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var imageAvatar: WebImageView = {
        let imageView = WebImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let descriptionLabel = UILabel(title: "foo")
    let nameLabel = UILabel(title: "foo")
    
    let profileView = UIView()
    
    // MARK: init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configuration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configuration() {
        addSubview(imageView)
        addSubview(descriptionLabel)
        addSubview(profileView)
        profileView.addSubview(imageAvatar)
        profileView.addSubview(nameLabel)
        layoutConfiguration()
    }
    
    private func layoutConfiguration() {
        imageAvatar.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageAvatar.heightAnchor.constraint(equalToConstant: ConstantsCellSize.profileImageHight),
            imageAvatar.widthAnchor.constraint(equalToConstant: ConstantsCellSize.profileImageHight),
            imageAvatar.leadingAnchor.constraint(equalTo: profileView.leadingAnchor),
            imageAvatar.centerYAnchor.constraint(equalTo: profileView.centerYAnchor)
        ])
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: imageAvatar.trailingAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: profileView.centerYAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: profileView.trailingAnchor)
        ])
    }
}

