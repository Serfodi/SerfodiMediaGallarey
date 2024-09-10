//
//  Configuration.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 06.09.2024.
//

import Foundation


public struct Configuration {
    let query: String
    let color: String?
    var page: Int = 1
    let perPage = 30
    
    private var search: String {
        let trimmedString = query.trimmingCharacters(in: .whitespaces)
        let replacedString = trimmedString.replacingOccurrences(of: " ", with: "+")
        return replacedString
    }
    
    var requestParameters: [String:String] {
        var parameters = ["query" : search]
        parameters["page"] = String(page)
        parameters["per_page"] = String(perPage)
        if let color = color { parameters["color"] = color }
        return parameters
    }
    
}
