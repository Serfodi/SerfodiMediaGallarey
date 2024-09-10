//
//  MetaInfoPhotoView.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 10.09.2024.
//

import UIKit


class MetaInfoPhotoView: UIView {
    
    init(photo: Photo) {
        super.init(frame: .zero)
        
        let header = nameLabel(photo: photo)
        let d = infoLabel(photo: photo)
        let f = configurationSegment(exif: photo.exif!)
        
        let segmetn = UIStackView(arrangedSubviews: [
            header,
            d,
            f
        ], axis: .vertical, spacing: 0)
        
        self.backgroundColor = ColorAppearance.lightGray
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        self.addSubview(segmetn)
        segmetn.toSuperView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

private extension MetaInfoPhotoView {
        
    
    func configurationSegment(exif: Exif) -> UIView {
        let apertureLabel = UILabel(title: "⨍ " + (exif.aperture ?? ""), fount: FontAppearance.mini, alignment: .center, color: ColorAppearance.darkGray)
        let exposureTimeLabel = UILabel(title: (exif.exposureTime ?? "-") + " s", fount: FontAppearance.mini, alignment: .center, color: ColorAppearance.darkGray)
        let focalLengthLabel = UILabel(title:  (exif.focalLength ?? "-") + " mm", fount: FontAppearance.mini, alignment: .center, color: ColorAppearance.darkGray)
        let segment = UIStackView(arrangedSubviews: [
            apertureLabel, exposureTimeLabel, focalLengthLabel
        ], axis: .horizontal, spacing: 0)
        segment.distribution = .fillEqually
        
        let view = UIView()
        view.layer.borderWidth = 0.8
        view.layer.borderColor = ColorAppearance.gray.cgColor
        
        view.addSubview(segment)
        segment.toSuperView(value: 10)
        
        return view
    }
    
    func infoLabel(photo: Photo) -> UIView {
        let view = UIView()
        let text = "\("Size".localized()): \(photo.width) ✕ \(photo.height) • \(photo.exif?.model ?? photo.exif?.name ?? "-")"
        let label = UILabel(title: text, fount: FontAppearance.mini, color: ColorAppearance.darkGray)
        view.addSubview(label)
        label.toSuperView(value: 10)
        return view
    }
    
    func nameLabel(photo: Photo) -> UIView {
        let view = UIView()
        view.backgroundColor = ColorAppearance.darkGray
        let label = UILabel(title: photo.exif?.name ?? "-", fount: FontAppearance.body, color: ColorAppearance.black)
        view.addSubview(label)
        view.layer.borderWidth = 0.8
        view.layer.borderColor = ColorAppearance.gray.cgColor
        label.toSuperView(value: 10)
        return view
    }
    
}
