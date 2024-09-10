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
    let exposureTime: String?
    let aperture: String?
    let focalLength: String?
//    let iso: String?
    
}

struct Location: Decodable {
    let city: String?
    let country: String?
}
