//
//  MetaInfoPhotoView.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 10.09.2024.
//

import UIKit


class MetaInfoPhotoView: UIView {
    
    let nameLabel =  UILabel(title: "-")
    let infoLabel = UILabel(title: nil, fount: FontAppearance.mini, color: ColorAppearance.darkGray)
    let apertureLabel = UILabel(title: "-", fount: FontAppearance.mini, alignment: .center, color: ColorAppearance.darkGray)
    let exposureTimeLabel = UILabel(title: "-", fount: FontAppearance.mini, alignment: .center, color: ColorAppearance.darkGray)
    let focalLengthLabel = UILabel(title:  "-", fount: FontAppearance.mini, alignment: .center, color: ColorAppearance.darkGray)
    
    private lazy var headerView = UIView(addView: nameLabel, value: 10, color: ColorAppearance.darkGray)
    private lazy var bodyView = UIView(addView: infoLabel, value: 10, color: ColorAppearance.lightGray)
    private lazy var footerView = UIView(addView: footerStack, value: 10)
    
    private lazy var footerStack: UIStackView = {
        let views = [apertureLabel, exposureTimeLabel, focalLengthLabel]
        let stack = UIStackView(arrangedSubviews: views, axis: .horizontal, spacing: 0)
        stack.distribution = .fillEqually
        return stack
    }()
    
    
    
    init(photo: Photo) {
        super.init(frame: .zero)
        
        nameLabel.text = photo.exif?.model
        var infoText = "\("Size".localized()): \(photo.width) ✕ \(photo.height)"
        if let name = photo.exif?.name {
            infoText += "\n\(name)"
        }
        infoLabel.text = infoText
        if let aperture = photo.exif?.aperture {
            apertureLabel.text = "⨍ " + aperture
        }
        if let exposure = photo.exif?.exposureTime {
            exposureTimeLabel.text = exposure + " s"
        }
        if let focalLength = photo.exif?.focalLength {
            focalLengthLabel.text = focalLength + " mm"
        }
        configurationView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let pathShadows = UIBezierPath(rect: CGRect(origin: .zero, size: CGSize(width: self.bounds.width, height: 0.5)))
        footerView.addShadow(color: ColorAppearance.darkGray, path: pathShadows)
        
        footerStack.arrangedSubviews.dropFirst().forEach {
            let size = CGSize(width: 0.5, height: FontAppearance.mini.lineHeight)
            let path = UIBezierPath(rect: CGRect(origin: CGPoint(x: $0.frame.maxX, y: $0.frame.minY), size: size) )
            $0.addShadow(color: ColorAppearance.darkGray, path: path)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension MetaInfoPhotoView {
        
    func configurationView() {
        self.backgroundColor = ColorAppearance.lightGray
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        infoLabel.numberOfLines = 2
        let stack = UIStackView(arrangedSubviews: [headerView, bodyView, footerView], axis: .vertical, spacing: 0)
        addSubview(stack)
        stack.edgesToSuperView()
    }
    
    
}
