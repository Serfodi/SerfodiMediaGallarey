//
//  UITableView + Extension.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 07.09.2024.
//

import UIKit

extension UITableViewCell {
    
    static var reuseIdentifier: String {
        String(describing: self)
    }
    
    var reuseIdentifier: String {
        type(of: self).reuseIdentifier
    }
}


extension UITableView {
    
    func register<T: UITableViewCell>(_ type: T.Type) {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func reuse<T: UITableViewCell>(_ type: T.Type, _ indexPath: IndexPath) -> T {
        dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
}

