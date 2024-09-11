//
//  CalculateCellSize.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 07.09.2024.
//

import UIKit

protocol PhotoSizeModel {
    var width: Int { get }
    var height: Int { get }
}

struct PhotoCellModel: PhotoSizeModel {
    var width: Int
    var height: Int
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
    
    private let numberRow: Int
    
    init(numberRow: Int) {
        self.numberRow = numberRow
    }
    
    func cellWidth(for row: Int) -> CGFloat {
        floor( (UIScreen.main.bounds.width - StaticCellSize.padding * Double(row + 1)) / Double(row) )
    }
    
    /// Static Height
    ///
    /// Using for collection View when `row != 1`
    func cellStaticHeight() -> CGFloat {
        UIScreen.main.bounds.width * 0.7
    }
    
    
    func sizes(description: String?, photo: any PhotoSizeModel) -> any MediaCellSize {
        if numberRow == 1 {
            return dynamicSizes(description: description, photo: photo)
        } else {
            return staticSizes(description: description, photo: photo)
        }
    }
}

// MARK: Calculate Cell Size

private extension CalculateCellSize {
    
    /// Calculate size in dynamic height
    func dynamicSizes(description: String?, photo: PhotoSizeModel) -> MediaCellSize {
        let width = cellWidth(for: numberRow)
        
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
            descriptionFrame.origin = CGPoint(x: 0, y: photoFrame.maxY + StaticCellSize.padding2)
        }
        
        // Profile
        let profileViewFrame = CGRect(x: 0, y: max(descriptionFrame.maxY, photoFrame.maxY) + StaticCellSize.padding2, width: width, height: StaticCellSize.profileImageHight)
        
        // Total
        let totalHeight = profileViewFrame.maxY
                
        return Sizes(imageViewFrame: photoFrame,
                     descriptionLabelFrame: descriptionFrame,
                     profileViewFrame: profileViewFrame,
                     totalSize: CGSize(width: width, height: totalHeight))
    }
    
    
    /// Calculate size cell item where column != 1
    func staticSizes(description: String?, photo: PhotoSizeModel) -> MediaCellSize {
        let width = cellWidth(for: numberRow)
        let height = cellStaticHeight()
        
        // Profile
        let profileViewFrame = CGRect(x: 0, y: height - StaticCellSize.profileImageHight, width: width, height: StaticCellSize.profileImageHight)
        
        // Label
        let descriptionFrame = CGRect.zero
//        var descriptionFrame = CGRect(origin: CGPoint(x: 0, y: height), size: .zero)
//        if let text = description, !text.isEmpty {
//            let height = text.height(width: width)
//            descriptionFrame.size = CGSize(width: width, height: height)
//            descriptionFrame.origin = CGPoint(x: 0, y: profileViewFrame.minY - height - StaticCellSize.padding2)
//        }
        
        // Photo
//        let imageHeight = min(descriptionFrame.minY, profileViewFrame.minY) - StaticCellSize.padding2
        let imageHeight = profileViewFrame.minY - StaticCellSize.padding2
        let photoSize = CGSize(width: width, height: imageHeight)
        let photoFrame = CGRect(origin: .zero, size: photoSize)
        
        return Sizes(imageViewFrame: photoFrame,
                     descriptionLabelFrame: descriptionFrame,
                     profileViewFrame: profileViewFrame,
                     totalSize: CGSize(width: width, height: height))
    }
    
}
