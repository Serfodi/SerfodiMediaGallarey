//
//  UIBarButtonItem + Extension.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 07.09.2024.
//

import UIKit

extension UIBarButtonItem {
    
    convenience init(image: UIImage?, _ accessibility: String, _ target: Any?, _ action: Selector) {
        self.init(image: image, style: .done, target: target, action: action)
        accessibilityLabel = description
    }
    
    convenience init(image: UIImage?, _ accessibility: String, _ menu: UIMenu?) {
        self.init(image: image, menu: menu)
        accessibilityLabel = description
    }
    
}
