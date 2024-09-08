//
//  String.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 06.09.2024.
//

import UIKit

extension String {
    
    func localized() -> String {
        return NSLocalizedString(self, comment: self)
    }
}

extension String {
    
    func height(width: CGFloat, font: UIFont = FontAppearance.body) -> CGFloat {
        let textSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        let size = self.boundingRect(with: textSize,
                                     options: .usesLineFragmentOrigin,
                                     attributes: [.font : font],
                                     context: nil)
        return ceil(size.height)
    }
    
}
