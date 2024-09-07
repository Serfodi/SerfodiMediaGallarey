//
//  ErrorDescription.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 06.09.2024.
//

import Foundation

enum ErrorDescription: Error, LocalizedError {
    case description(String)
    
    var errorDescription: String? {
        switch self {
        case .description(let text):
            return "Error: \(text)"
        }
    }
}
