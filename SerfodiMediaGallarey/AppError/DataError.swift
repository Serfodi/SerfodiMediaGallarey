//
//  DataError.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 10.09.2024.
//

import Foundation

enum DataError: Error, LocalizedError {
    case notData
    
    var errorDescription: String? {
        switch self {
        case .notData:
            return "Data is nil".localized()
        }
    }
}
