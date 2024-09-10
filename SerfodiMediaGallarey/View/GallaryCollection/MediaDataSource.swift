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
    
    /// Called when a cell is `selected`
    public var selected: ((String) -> ())?
    
    /// Called when a scroll is end collection
    public var didEndCollection: (() -> ())?
    
    init(_ collectionView: UICollectionView) {
        super.init(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            return collectionView.reuse(MediaViewCell.self, with: itemIdentifier, indexPath)
        }
    }

    func registerFooter(_ view: UICollectionView.SupplementaryRegistration<LoadIndicatorView>) {
        supplementaryViewProvider = { (collectionView, elementKind, indexPath) -> UICollectionReusableView? in
            return collectionView.dequeueConfiguredReusableSupplementary(using: view, for: indexPath)
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        CGSize(width: 50, height: 50)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if (offsetY) > (contentHeight - height) {
            guard let didEndCollection = didEndCollection else { return }
            didEndCollection()
        }
    }
    
}
