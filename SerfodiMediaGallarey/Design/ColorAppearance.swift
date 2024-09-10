//
//  ColorAppearance.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 06.09.2024.
//

import UIKit

enum ColorAppearance {
    static let black = SchemeColor(light: .black, dark: .white.withAlphaComponent(0.7)).color()
    static let white = SchemeColor(light: .white, dark: .black).color()
    static let blue = UIColor.systemBlue
    static let lightGray = SchemeColor(light: #colorLiteral(red: 0.9601849914, green: 0.9601849914, blue: 0.9601849914, alpha: 1)).color()
    static let darkGray = SchemeColor(light: #colorLiteral(red: 0.7087258697, green: 0.7087258697, blue: 0.7087258697, alpha: 1)).color()
    static let gray = SchemeColor(light: #colorLiteral(red: 0.8374213576, green: 0.8374213576, blue: 0.8374213576, alpha: 1)).color()
}
