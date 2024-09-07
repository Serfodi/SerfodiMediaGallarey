//
//  MediaCellModel.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 06.09.2024.
//

import Foundation

protocol MediaDisplayModel {
    var imageURL: String { get }
    var description: String { get }
    var imageAvatar: String { get }
    var name: String { get }
//    var data: Date { get }
//    var views: Int { get }
}

struct MediaCellModel: MediaDisplayModel {
    var id: String
    
    /* MediaCellModel */
    var imageURL: String
    var description: String
    var imageAvatar: String
    var name: String
//    var data: Date
//    var views: Int
}

extension MediaCellModel: Hashable {}
