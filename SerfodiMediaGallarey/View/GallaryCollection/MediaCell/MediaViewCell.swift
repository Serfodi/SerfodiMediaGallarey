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
    let descriptionLabel = UILabel(title: nil)
    let profileView = ProfileView()
    let likeLabel = UILabel(title: "boo", fount: FontAppearance.mini, alignment: .center)
    let dataLabel = UILabel(title: "boo", fount: FontAppearance.mini, alignment: .center)
    
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
     
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.cancelDownload()
        profileView.imageAvatar.cancelDownload()
    }
    
    // MARK: Helpers
    
    private func accessibility() {
        var description: String? = nil
        if let text = descriptionLabel.text, !text.isEmpty {
            description = "\("WriteDescription".localized()): \(text)"
        }
        accessibilityLabel = [
            profileView.nameLabel.text,
            description
        ].compactMap{$0}.joined(separator: ",")
    }
    
}

extension MediaViewCell: SelfConfiguringCell {
    
    func configure<U>(with value: U) where U : Hashable {
        guard let media: MediaDisplayModel = value as? MediaDisplayModel else { return }
        self.media = media
        
        imageView.image = nil
        profileView.imageAvatar.image = nil
        
        if let url = URL(string: media.imageURL) {
            imageView.asyncSetImage(url: url)
        }
        descriptionLabel.text = media.description
        profileView.set(user: media.user)
        likeLabel.text = "👍 \(media.like)"
        dataLabel.text = media.date.formateDate()
        imageView.frame = media.size.imageViewFrame
        descriptionLabel.frame = media.size.descriptionLabelFrame
        profileView.frame = media.size.profileViewFrame
        accessibility()
    }
    
}

private extension MediaViewCell {
    
    func configuration() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 13
        descriptionLabel.numberOfLines = 0
        imageView.backgroundColor = ColorAppearance.lightGray
    }
    
    private func configurationFrame() {
        addSubview(descriptionLabel)
        addSubview(imageView)
        addSubview(profileView)
        
        let likeLabelView = UIView.blurConfiguration(addView: likeLabel, height: likeLabel.font.lineHeight, padding: 3)
        let dataLabelView =  UIView.blurConfiguration(addView: dataLabel, height: dataLabel.font.lineHeight, padding: 3)
        
        imageView.addSubview(likeLabelView)
        imageView.addSubview(dataLabelView)
        
        likeLabelView.bottomToSuperview(value: 2)
        likeLabelView.leadingToSuperview(value: 2)
        dataLabelView.bottomToSuperview(value: 2)
        dataLabelView.trailingToSuperview(value: 2)
    }
    
}
