//
//  MediaCellModel.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 06.09.2024.
//

import Foundation

protocol MediaDisplayModel {
    var imageURL: String { get }
    var description: String? { get }
    var imageAvatar: String { get }
    var name: String { get }
    var size: MediaCellSize { get }
    var data: Date { get }
    var like: Int { get }
}

struct MediaCellModel: MediaDisplayModel {
    
    var id: String
    
    /* MediaCellModel */
    var imageURL: String
    var description: String?
    var imageAvatar: String
    var name: String
    var size: MediaCellSize
    var data: Date
    var like: Int
    
}

extension MediaCellModel: Hashable {
    
    static func == (lhs: MediaCellModel, rhs: MediaCellModel) -> Bool {
        lhs.size.totalSize == rhs.size.totalSize && lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}
