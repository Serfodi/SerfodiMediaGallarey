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
    static let gray = SchemeColor(light: #colorLiteral(red: 0.9294117647, green: 0.9294117647, blue: 0.9294117647, alpha: 1)).color()
}
