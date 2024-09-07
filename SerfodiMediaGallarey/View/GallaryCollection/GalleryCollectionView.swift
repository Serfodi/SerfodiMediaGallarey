//
//  GalleryCollectionView.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 06.09.2024.
//

import UIKit

class GalleryCollectionView: UICollectionView {

    
    
    // MARK: init
    
    public init() {
//        UICollectionViewCompositionalLayout.create()
        var collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.itemSize = UICollectionViewFlowLayout.automaticSize
        super.init(frame: .zero, collectionViewLayout: collectionLayout)
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

fileprivate extension UICollectionViewCompositionalLayout {
    
    static func create() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout(section: self.createUserSection())
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 30
        layout.configuration = config
        return layout
    }
    
    private static func createUserSection() -> NSCollectionLayoutSection {
        let itemCount = 2
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        var groupSize = NSCollectionLayoutSize(widthDimension: .absolute(1), heightDimension: .absolute(1))
        
        groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalWidth(0.7))
        var group = NSCollectionLayoutGroup(layoutSize: groupSize)
        
        group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: itemCount)
        
        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 10, leading: 10, bottom: 0, trailing: 0)
        
        return section
    }
    
}
