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
