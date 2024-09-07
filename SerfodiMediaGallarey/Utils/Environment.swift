//
//  Environment.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 06.09.2024.
//

import Foundation

public struct Environment {
    enum Keys {
        static let accessKey = "Access_Key"
    }
    
    /// Get the `Access_Key`  from `Info.plist`
    static let accessKey: String = {
        guard let accessKeyProperty = Bundle.main.object(
            forInfoDictionaryKey: Keys.accessKey
        ) as? String else {
            fatalError("Access_Key not found")
            
            /*
             Для проверки приложения вставьте свой ключ в Services -> API -> accessKey
             */
            
        }
        return accessKeyProperty
    }()
}
