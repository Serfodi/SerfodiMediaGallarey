//
//  User.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 06.09.2024.
//

import UIKit

struct User: Decodable {
    
    struct ProfileImageSize: Decodable {
        let small: String?
    }
    
    struct Links: Decodable {
        let html: String?
    }
    
    let id: String
    let username: String
    let profileImage: ProfileImageSize
    let links: Links?
    let instagramUsername: String?
    let twitterUsername: String?
    
}
