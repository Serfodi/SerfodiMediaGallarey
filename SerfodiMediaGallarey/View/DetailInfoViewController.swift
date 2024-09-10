//
//  DetailInfoViewController.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 09.09.2024.
//

import UIKit

class DetailInfoViewController: UIViewController {

    let titleLabel = UILabel(title: "Information".localized(), fount: FontAppearance.title, alignment: .center)
    let descriptionLabel = UILabel(title: "foo")
    // дата
    let titleDateLabel = UILabel(title: "foo")
    // Кол-во просмотров
    let likedLabel = UILabel(title: "foo")
    let locationLabel = UILabel(title: "foo")
    
    let profileView = ProfileView()
    
    var exifView: MetaInfoPhotoView!
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy. HH:mm:ss"
        return dateFormatter
    }()
    
    let photo: Photo
    
    init(photo: Photo) {
        self.photo = photo
        super.init(nibName: nil, bundle: nil)
        
        exifView = MetaInfoPhotoView(photo: photo)
        
        profileView.set(user: photo.user)
        
        descriptionLabel.text = photo.description
        titleDateLabel.text = dateFormatter.string(from: photo.createdAt ?? Date())
        
        if let location = photo.location {
            locationLabel.text = [location.country, location.city].compactMap { $0 }.joined(separator: ",")
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
        view.backgroundColor = ColorAppearance.white
    }
    
    func configuration() {
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(exifView)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        exifView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor).isActive = true
        
        descriptionLabel.numberOfLines = 0
        
        var verticalStack = UIStackView(
            arrangedSubviews: [descriptionLabel, exifView, titleDateLabel, locationLabel, profileView],
            axis: .vertical, spacing: 20)
        
        view.addSubview(verticalStack)
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            verticalStack.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            verticalStack.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
        ])
    }
}
