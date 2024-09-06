//
//  MediaDataSource.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 06.09.2024.
//

import UIKit

enum Section: Hashable {
    case main
}

final class MediaDataSource: UICollectionViewDiffableDataSource<Section, MediaCellModel> {
    
    private var data : [MediaCellModel]?
    
    public var mediaItems: [MediaCellModel] {
        data ?? []
    }
    
    init(_ collectionView: UICollectionView) {
        super.init(collectionView: collectionView) { tableView, indexPath, itemIdentifier in
            return tableView.reuse(MediaViewCell.self, with: itemIdentifier, indexPath)
        }
    }

    func reload(_ data: [MediaCellModel], animated: Bool = true) {
        self.data = data
        var snapshot = NSDiffableDataSourceSnapshot<Section, MediaCellModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(data, toSection: .main)
        self.apply(snapshot, animatingDifferences: animated)
    }
}
