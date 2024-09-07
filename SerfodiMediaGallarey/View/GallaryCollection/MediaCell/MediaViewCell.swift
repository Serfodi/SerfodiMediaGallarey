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
        self.backgroundConfiguration = config
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        view.imageView.cancelDownload()
        view.imageAvatar.cancelDownload()
    }
    
    private func accessibility() {
        var description: String? = nil
        if let text = view.descriptionLabel.text, !text.isEmpty {
            description = "\("WriteDescription".localized()): \(text)"
        }
        accessibilityLabel = [view.nameLabel.text, description].compactMap{$0}.joined(separator: ",")
    }
}

extension MediaViewCell: SelfConfiguringCell {
    
    func configure<U>(with value: U) where U : Hashable {
        guard let media: MediaDisplayModel = value as? MediaDisplayModel else { return }
        self.media = media
        
        // configuration content
        view.descriptionLabel.text = media.description
        view.nameLabel.text = media.name
        if let url = URL(string: media.imageURL) {
            view.imageView.set(url: url)
        }
        if let url = URL(string: media.imageAvatar) {
            view.imageAvatar.set(url: url)
        }
        
        // configuration Frame
        let frames = media.size
        view.imageView.frame = frames.imageViewFrame
        view.descriptionLabel.frame = frames.descriptionLabelFrame
        view.profileView.frame = frames.profileViewFrame
        
        // configuration accessibility
        accessibility()
    }
    
}
