//
//  String.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 06.09.2024.
//

import Foundation

extension String {
    
    func localized() -> String {
        return NSLocalizedString(self, comment: self)
    }
}
