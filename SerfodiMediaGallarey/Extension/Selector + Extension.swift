//
//  Selector + Extension.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 10.09.2024.
//

import UIKit

extension Selector {
    
    static func open(url: URL?) {
        guard let url = url else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
}


