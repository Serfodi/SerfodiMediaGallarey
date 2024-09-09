//
//  GalleryCollectionView.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 06.09.2024.
//

import UIKit

class GalleryCollectionView: UICollectionView {
    
    enum DisplayLayout: Int {
        case one = 1
        case two = 2
        
        mutating func toggle() {
            switch self {
            case .one: self = .two
            case .two: self = .one
            }
        }
    }
    
    private var layout = CollectionViewFlowLayout()
    
    /// Updates the collection grid
    open var displayLayout: DisplayLayout = .one {
        didSet {
            guard displayLayout != oldValue else { return }
            layout.column = displayLayout.rawValue
            setCollectionViewLayout(layout, animated: true)
        }
    }
    
    // MARK: init
        
    init() {
        super.init(frame: .zero, collectionViewLayout: layout)
        configuration()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: metods
    
    public func layoutConstraints(in view: UIView) -> [NSLayoutConstraint] {
        [
            topAnchor.constraint(equalTo: view.topAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ]
    }
    
    // MARK: Configuration
    
    private func configuration() {
        translatesAutoresizingMaskIntoConstraints = false
        allowsMultipleSelection = false
    }
}


class CollectionViewFlowLayout : UICollectionViewFlowLayout {
    
    public var column: Int = 1
        
    override func prepare() {
        sectionInset = UIEdgeInsets.init(top: 0, left: StaticCellSize.padding, bottom: 0, right: StaticCellSize.padding)
        self.itemSize = UICollectionViewFlowLayout.automaticSize
    }
}
