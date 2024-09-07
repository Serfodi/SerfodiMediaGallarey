//
//  SelfConfiguringCell.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 06.09.2024.
//

import UIKit

protocol SelfConfiguringCell : UICollectionViewCell {
    func configure<U: Hashable>(with value: U)
}
