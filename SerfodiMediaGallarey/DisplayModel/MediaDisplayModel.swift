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
    var user: User { get }
    var size: MediaCellSize { get }
    var date: Date { get }
    var like: Int { get }
}

struct MediaCellModel: MediaDisplayModel {
    
    var id: String
    
    /* MediaCellModel */
    var imageURL: String
    var description: String?
    var user: User
    var size: MediaCellSize
    var date: Date
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

extension MediaCellModel {
    
    enum ValueSort {
        case likes
        case date
    }
    
}
 
