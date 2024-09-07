//
//  API.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 06.09.2024.
//

import Foundation

enum API {
    static let scheme = "https"
    static let host = "api.unsplash.com"
    
    // endpoints
    static let photosPath = "/search/photos"
    
    // keys
    static let accessKey =  Environment.accessKey
}
