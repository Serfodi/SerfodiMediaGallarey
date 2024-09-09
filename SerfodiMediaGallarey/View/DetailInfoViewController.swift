//
//  DetailInfoViewController.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 09.09.2024.
//

import UIKit

class DetailInfoViewController: UIViewController {

    let titleLabel = UILabel(title: "Information".localized(), fount: FontAppearance.title, alignment: .center)
    let descriptionLabel = UILabel(title: "foo", alignment: .center)
    // дата
    let titleDateLabel = UILabel(title: "foo")
    // информация о фото (высота, ширина)
    let photoInfoLabel = UILabel(title: "foo")
    // Кол-во просмотров
    let likedLabel = UILabel(title: "foo")
    let locationLabel = UILabel(title: "foo")
    let cameraInfo = UILabel(title: "")
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy. HH:mm:ss"
        return dateFormatter
    }()
    
    let photo: Photo
    
    init(photo: Photo) {
        self.photo = photo
        super.init(nibName: nil, bundle: nil)
        
        descriptionLabel.text = photo.description
        titleDateLabel.text = dateFormatter.string(from: photo.createdAt ?? Date())
        
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
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor).isActive = true
        
        var verticalStack = UIStackView(
            arrangedSubviews: [descriptionLabel, photoInfoLabel, titleDateLabel, likedLabel, locationLabel, cameraInfo],
            axis: .vertical, spacing: 8)
        
        view.addSubview(verticalStack)
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            verticalStack.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            verticalStack.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
        ])
        
        
    }
    
}
