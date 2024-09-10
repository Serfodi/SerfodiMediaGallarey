//
//  UIButton + Extension.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 09.09.2024.
//

import UIKit

extension UIButton {
    
    func accessibility(_ text: String) -> Self {
        self.accessibilityLabel = text
        return self
    }
    
}

extension UIButton.Configuration {
    
    static func icons(_ image: UIImage?) -> Self {
        var configuration = UIButton.Configuration.filled()
        configuration.image = image
        configuration.cornerStyle = .capsule
        return configuration
    }
    
}
