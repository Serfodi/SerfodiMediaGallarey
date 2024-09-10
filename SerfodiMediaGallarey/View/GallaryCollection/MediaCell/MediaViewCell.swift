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
    let descriptionLabel = UILabel(title: "foo")
    let profileView = ProfileView()
    let likeLabel = UILabel(title: "boo", fount: FontAppearance.mini, alignment: .center, color: ColorAppearance.white)
    let dataLabel = UILabel(title: "boo", fount: FontAppearance.mini, alignment: .center, color: ColorAppearance.white)
    
    lazy var baseLikeView: UIView = {
        let effect = UIBlurEffect(style: .systemMaterialDark)
        let vibrancyEffect = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: effect))
        let effectView = UIVisualEffectView(effect: effect)
        effectView.contentView.addSubview(likeLabel)
        vibrancyEffect.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        likeLabel.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        return effectView
    }()
    
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
        imageView.layer.cornerRadius = 10
        descriptionLabel.numberOfLines = 0
        imageView.backgroundColor = ColorAppearance.lightGray
    }
    
    private func configurationFrame() {
        addSubview(imageView)
        addSubview(descriptionLabel)
        addSubview(profileView)
        imageView.addSubview(likeLabel)
        imageView.addSubview(dataLabel)
        
        likeLabel.translatesAutoresizingMaskIntoConstraints = false
        dataLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            likeLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -5),
            likeLabel.leftAnchor.constraint(equalTo: imageView.leftAnchor, constant: 5),
            dataLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -5),
            dataLabel.rightAnchor.constraint(equalTo: imageView.rightAnchor, constant: -5)
        ])
    }
    
}
