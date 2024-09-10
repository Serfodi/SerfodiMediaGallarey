//
//  Photo.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 06.09.2024.
//

import Foundation

struct Photo: Decodable {
    
    struct UrlsSize: Decodable {
        let small: String?
        let regular: String?
        let full: String?
        let thumb: String?
    }
    
    let id: String
    let width: Int
    let height: Int
    let createdAt: Date?
    let description: String?
    let user: User
    let urls: UrlsSize
    let likes: Int
    
    var exif: Exif?
    var location: Location?
    
}


