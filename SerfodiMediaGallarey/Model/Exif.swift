//
//  Exif.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 09.09.2024.
//

import Foundation

struct Exif: Decodable {
    
    let aperture: String
    let exposureTime: String
    let focalLength: String
    let iso: String
    let make: String
    let model: String
}

struct Location: Decodable {
    let city: String?
    let country: String?
}
