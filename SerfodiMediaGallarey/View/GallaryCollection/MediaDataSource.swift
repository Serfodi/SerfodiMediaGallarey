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
    
    public var selected: ((String) -> ())?
    
    init(_ collectionView: UICollectionView) {
        super.init(collectionView: collectionView) { tableView, indexPath, itemIdentifier in
            return tableView.reuse(MediaViewCell.self, with: itemIdentifier, indexPath)
        }
    }

    func reload(_ data: [MediaCellModel], animated: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, MediaCellModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(data, toSection: .main)
        self.apply(snapshot, animatingDifferences: animated)
    }
}

extension MediaDataSource: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let sectionId = sectionIdentifier(for: indexPath.section) else { return .zero }
        switch sectionId {
        case .main:
            guard let model = itemIdentifier(for: indexPath) else { return .zero }
            return model.size.totalSize
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let sectionId = sectionIdentifier(for: indexPath.section) else { return }
        switch sectionId {
        case .main:
            guard let model = itemIdentifier(for: indexPath), let selected = selected else { return }
            selected(model.id)
        }
    }
    
}
