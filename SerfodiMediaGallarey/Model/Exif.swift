//
//  Exif.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 09.09.2024.
//

import Foundation

struct Exif: Decodable {
    
    let make: String?
    let model: String?
    let name: String?
    let aperture: Double?
    let focalLength: Int?
    let iso: Int?
}

struct Location: Decodable {
    let city: String?
    let country: String?
}
