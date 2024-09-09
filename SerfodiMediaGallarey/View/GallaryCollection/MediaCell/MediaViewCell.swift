//
//  MediaViewCell.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 06.09.2024.
//

import UIKit

class MediaViewCell: UICollectionViewCell {
    
    /// Model Cell
    var media: MediaDisplayModel?
    
    let imageView = WebImageView()
    let imageAvatar = WebImageView()
    let descriptionLabel = UILabel(title: "foo")
    let nameLabel = UILabel(title: "foo")
    let profileView = UIView()
        
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isAccessibilityElement = true
        accessibilityTraits = .button
        clipsToBounds = true
        configuration()
        configurationFrame()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    // MARK: Helpers
    
    private func accessibility() {
        var description: String? = nil
        if let text = descriptionLabel.text, !text.isEmpty {
            description = "\("WriteDescription".localized()): \(text)"
        }
        accessibilityLabel = [nameLabel.text, description].compactMap{$0}.joined(separator: ",")
    }
    
    private func updateFrame() {
        guard let size = media?.size else { return }
        imageView.frame = size.imageViewFrame
        descriptionLabel.frame = size.descriptionLabelFrame
        profileView.frame = size.profileViewFrame
    }
    
}

extension MediaViewCell: SelfConfiguringCell {
    
    func configure<U>(with value: U) where U : Hashable {
        guard let media: MediaDisplayModel = value as? MediaDisplayModel else { return }
        self.media = media
        
        // configuration content
        descriptionLabel.text = media.description
        nameLabel.text = media.name
        if let url = URL(string: media.imageURL ?? "") {
            imageView.set(url: url)
        }
        if let url = URL(string: media.imageAvatar ?? "") {
            imageAvatar.set(url: url)
        }
        
        updateFrame()
        accessibility()
    }
    
}

private extension MediaViewCell {
    
    func configuration() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageAvatar.contentMode = .scaleAspectFill
        imageAvatar.clipsToBounds = true
        imageAvatar.layer.cornerRadius = StaticCellSize.profileImageHight / 2
        descriptionLabel.numberOfLines = 0
    }
    
    private func configurationFrame() {
//        imageView.autoresizingMask = [.flexibleHeight, .flexibleWidth, .flexibleBottomMargin]
//        descriptionLabel.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
//        profileView.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
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
            imageAvatar.widthAnchor.constraint(equalToConstant: StaticCellSize.profileImageHight),
            imageAvatar.leadingAnchor.constraint(equalTo: profileView.leadingAnchor),
            imageAvatar.centerYAnchor.constraint(equalTo: profileView.centerYAnchor)
        ])
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: imageAvatar.trailingAnchor, constant: StaticCellSize.padding2),
            nameLabel.centerYAnchor.constraint(equalTo: profileView.centerYAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: profileView.trailingAnchor)
        ])
    }
    
}
