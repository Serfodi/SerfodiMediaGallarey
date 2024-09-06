//
//  ResponseWrapped.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 06.09.2024.
//

import Foundation

struct ResponseWrapped<T: Decodable>: Decodable {
    let results: [T]
}
