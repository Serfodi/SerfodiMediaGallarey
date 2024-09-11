//
//  DetailInfoViewController.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 09.09.2024.
//

import UIKit

class DetailInfoViewController: UIViewController {
    
    let titleLabel = UILabel(title: "Information".localized(), fount: FontAppearance.title, alignment: .center)
    let descriptionLabel = UILabel(title: nil)
    let titleDateLabel = UILabel(title: "foo", fount: FontAppearance.mini, color: ColorAppearance.darkGray)
    let likedLabel = UILabel(title: "foo")
    let locationLabel = UILabel(title: nil)
    let profileView = ProfileView()
    lazy var exifView = MetaInfoPhotoView(photo: photo)
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy. HH:mm:ss"
        return dateFormatter
    }()
    
    let photo: Photo
    
    init(photo: Photo) {
        self.photo = photo
        super.init(nibName: nil, bundle: nil)
        
        profileView.set(user: photo.user)
        likedLabel.text = "👍 \(photo.likes)"
        
        descriptionLabel.text = photo.description
        
        titleDateLabel.text = dateFormatter.string(from: photo.createdAt ?? Date())
        
        if let location = photo.location, let country = location.country, let city = location.city {
            locationLabel.text = "📍 \(country) • \(city)"
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorAppearance.white
        configuration()
        configurationLayout()
    }
    
    func configuration() {
        descriptionLabel.numberOfLines = 0
        self.sheetPresentationController?.prefersGrabberVisible = photo.description != nil
        if photo.description == nil {
            self.sheetPresentationController?.detents = [.medium()]
        }
    }
    
    func configurationLayout() {
        let stackDataAndLike = UIStackView(arrangedSubviews: [titleDateLabel, likedLabel], axis: .horizontal, spacing: 0)
        
        descriptionLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
        descriptionLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
        let verticalStack = UIStackView(
            arrangedSubviews: [titleLabel, descriptionLabel, UIView(), exifView, stackDataAndLike, locationLabel, profileView],
            axis: .vertical, spacing: 10)
        self.view.addSubview(verticalStack)
        verticalStack.topToSuperview(value: 20)
        verticalStack.trailingToSuperview(value: 10)
        verticalStack.leadingToSuperview(value: 10)
        verticalStack.bottomToSuperview(value: 10, usingSafeArea: true)
    }
    
}
