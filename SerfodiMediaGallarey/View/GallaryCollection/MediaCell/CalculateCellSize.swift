//
//  CalculateCellSize.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 07.09.2024.
//

import Foundation

protocol PhotoSizeModel {
    var width: Int { get }
    var height: Int { get }
}

/// Describes the dimensions of the elements in the cells
protocol MediaCellSize {
    var imageViewFrame: CGRect { get }
    var descriptionLabelFrame: CGRect { get }
    var profileViewFrame: CGRect { get }
    var totalSize: CGSize { get }
}

/// Calculates cell sizes based on dynamic content
protocol FeedCellLayoutCalculatorProtocol {
    func sizes(description: String?, photo: PhotoSizeModel) -> MediaCellSize
}

/// Calculates the dimensions of the cell contents based on the available width and the contents of the cell
final class CalculateCellSize: FeedCellLayoutCalculatorProtocol {
    
    struct Sizes: MediaCellSize {
        var imageViewFrame: CGRect
        var descriptionLabelFrame: CGRect
        var profileViewFrame: CGRect
        var totalSize: CGSize
    }
    
    private let screenWidth: CGFloat
    
    init(screenWidth: CGFloat) {
        self.screenWidth = screenWidth
    }
    
    func sizes(description: String?, photo: PhotoSizeModel) -> MediaCellSize {
        
        let width = screenWidth
        
        // Photo
        let ration: CGFloat = CGFloat( Float(photo.height) / Float(photo.width) )
        let height = width * ration
        let photoSize = CGSize(width: width, height: height)
        let photoFrame = CGRect(origin: .zero, size: photoSize)
        
        // Label
        var descriptionFrame = CGRect.zero
        if let text = description, !text.isEmpty {
            let height = text.height(width: width)
            descriptionFrame.size = CGSize(width: width, height: height)
            descriptionFrame.origin = CGPoint(x: 0, y: photoFrame.maxY)
        }
        
        // Profile
        let profileViewFrame = CGRect(x: 0, y: max(descriptionFrame.maxY, photoFrame.maxY), width: width, height: ConstantsCellSize.profileImageHight)
        
        // Total
        let totalHeight = profileViewFrame.maxY
        
        return Sizes(imageViewFrame: photoFrame,
                     descriptionLabelFrame: descriptionFrame,
                     profileViewFrame: profileViewFrame,
                     totalSize: CGSize(width: width, height: totalHeight))
    }
    
}
