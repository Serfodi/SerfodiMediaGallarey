//
//  ProfileView.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 10.09.2024.
//

import UIKit

class ProfileView: UIView {

    let imageAvatar = WebImageView()
    let nameLabel = UILabel(title: "foo")
    let button = UIButton()
    
    init() {
        super.init(frame: .zero)
        configuration()
        configurationLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func set(user: User) {
        if let url = URL(string: user.profileImage.small ?? "") {
            imageAvatar.asyncSetImage(url: url)
        }
        nameLabel.text = user.username
        
        let ref = [user.instagramUsername, user.twitterUsername, user.links?.html].compactMap{ $0 }
        
        var action = [UIAction]()
        if let insta = user.instagramUsername {
            action.append(UIAction(title: "Instagram", handler: { _ in
                Selector.open(url: URL(string: "https://www.instagram.com/\(insta)"))
            }))
        }
        if let twitter = user.twitterUsername {
            action.append(UIAction(title: "Twitter", handler: { _ in
                Selector.open(url: URL(string: "https://www.twitter.com/\(twitter)"))
            }))
        }
        action.append(UIAction(title: "Unsplash", handler: { _ in
            Selector.open(url: URL(string: user.links?.html ?? ""))
        }))
        
        configurationMenu(action: action)
    }
    
    private func configurationMenu(action: [UIAction]) {
        let image = StaticImage.ellipsis!.withTintColor(ColorAppearance.black, renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        button.menu = UIMenu(children: action)
        button.showsMenuAsPrimaryAction = true
    }
    
    private func configuration() {
        imageAvatar.contentMode = .scaleAspectFill
        imageAvatar.clipsToBounds = true
        imageAvatar.layer.cornerRadius = StaticCellSize.profileImageHight / 2
        imageAvatar.backgroundColor = ColorAppearance.lightGray
    }
    
    private func configurationLayout() {
        addSubview(imageAvatar)
        addSubview(nameLabel)
        addSubview(button)
        
        imageAvatar.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageAvatar.topAnchor.constraint(equalTo: topAnchor),
            imageAvatar.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageAvatar.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageAvatar.widthAnchor.constraint(equalToConstant: StaticCellSize.profileImageHight)
        ])
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: imageAvatar.trailingAnchor, constant: StaticCellSize.padding2),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: button.leadingAnchor)
        ])
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: centerYAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
    }
    
}
