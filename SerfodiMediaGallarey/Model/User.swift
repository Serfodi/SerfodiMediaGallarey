//
//  User.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 06.09.2024.
//

import UIKit

struct User: Decodable {
    
    struct ProfileImageSize: Decodable {
        let small: String
    }
    
    let id: String
    let username: String
    let profileImage: ProfileImageSize
    
}
