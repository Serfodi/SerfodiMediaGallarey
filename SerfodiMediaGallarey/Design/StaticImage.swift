//
//  StaticImage.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 07.09.2024.
//

import UIKit

enum StaticImage {
    
    enum SizeIcon {
        static let size = CGSize(width: 40, height: 40)
        static var width = { size.width }
        static var height = { size.height }
    }
    
    static let orderBy = UIImage(systemName: "line.3.horizontal.decrease.circle")
    static let displayMode = UIImage(systemName: "rectangle.3.group")
    static let searchIcon = UIImage(systemName: "magnifyingglass")
    static let colorIcon = UIImage(systemName: "circle.fill")
    static let popularIcon = UIImage(systemName: "hand.thumbsup")
    static let dateIcon = UIImage(systemName: "calendar")
    static let closeIcon = UIImage(systemName: "xmark")
    static let sharedIcon = UIImage(systemName: "arrow.up")
    static let downloadIcon = UIImage(systemName: "arrow.down")
    static let infoIcon = UIImage(systemName: "info")
    static let ellipsis = UIImage(systemName: "ellipsis")
    static let doneIcon = UIImage(systemName: "checkmark.circle")
    static let errorIcon = UIImage(systemName: "exclamationmark.circle.fill")
    static let tryAgain = UIImage(systemName: "arrow.clockwise.circle.fill")
    static let imageStar = UIImage(systemName: "star.fill")
}

