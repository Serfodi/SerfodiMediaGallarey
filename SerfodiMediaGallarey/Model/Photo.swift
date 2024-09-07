//
//  Photo.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 06.09.2024.
//

import Foundation

struct Photo: Decodable {
    
    struct UrlsSize: Decodable {
        let regular: String?
    }
    
    struct Links: Decodable {
        let download: String
    }
    
    let id: String
    let width: Int
    let height: Int
    let createdAt: String
    let description: String?
    let user: User
    let links: Links
    let urls: UrlsSize
    
}


