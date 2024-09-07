//
//  MediaViewCell.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 06.09.2024.
//

import UIKit

class MediaViewCell: UICollectionViewCell {
    
    var media: MediaDisplayModel?
    var view = MediaView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isAccessibilityElement = true
        accessibilityTraits = .button
        var config = defaultBackgroundConfiguration()
        config.customView = view
        config.cornerRadius = 10
        self.backgroundConfiguration = config
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        view.imageView.cancelDownload()
        view.imageAvatar.cancelDownload()
    }
    
}

extension MediaViewCell: SelfConfiguringCell {
    
    func configure<U>(with value: U) where U : Hashable {
        guard let media: MediaDisplayModel = value as? MediaDisplayModel else { return }
        self.media = media
        view.descriptionLabel.text = media.description
        view.nameLabel.text = media.name
        view.imageView.image = UIImage(systemName: "photo.fill")
        view.imageAvatar.image = UIImage(systemName: "photo.fill")
        if let url = URL(string: media.imageURL) {
            view.imageView.set(url: url)
        }
        if let url = URL(string: media.imageAvatar) {
            view.imageAvatar.set(url: url)
        }
    }
    
}
