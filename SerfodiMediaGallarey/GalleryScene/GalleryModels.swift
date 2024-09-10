//
//  GalleryModels.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 06.09.2024.
//

import UIKit

enum Gallery {
    // MARK: Use cases
    
    enum Something {
        enum Request {
            /// Сделать запрос на поиск фото
            case search(parameters: Configuration)
            /// Загрузить новые фото
            case loadPage
            /// Перезагрузить страничку фото со старым запросом
            case refreshPage
            /// Изменить сетку коллекции
            case changeGrid
            /// Изменить порядок сортировки
            case orderBy
            /// Изменить принцип сортировки
            case sortedValue(MediaCellModel.ValueSort)
            /// Дать модель фото для передачи по нажатию на ячейку
            case getPhoto(id: String)
        }
        enum Response {
            case presentPhotos(photos:[Photo])
            case presentError(Error)
            /// Загрузить новые фото
            case presentFooterLoader
            case presentNewPhotos(photos:[Photo])
            /// Перезагрузить страничку фото со старым запросом
            case presentRefreshPhotos(photos:[Photo])
            /// Изменить сетку коллекции
            case presentChangeGrid(photos:[Photo])
            /// Изменить порядок сортировки
            case presentOrderBy(photos:[Photo])
            /// Изменить принцип сортировки
            case presentSortedValue(photos:[Photo], sortedValue: MediaCellModel.ValueSort)
            /// Дать модель фото для передачи по нажатию на ячейку
            case presentSelectedPhoto
        }
        enum ViewModel {
            case displayMedia(media: [MediaCellModel])
            case displayError(String)
            /// Показать новые фото
            case displayNewMedia(media:[MediaCellModel])
            case displayFooterLoader
            /// Показать обновления фото
            case displayRefreshMedia(media:[MediaCellModel])
            /// Показать изменения сетки коллекции
            case displayNewGrid(media:[MediaCellModel], display: GalleryCollectionView.DisplayLayout)
            /// Показать фото
            case displaySelectedPhoto
        }
    }
}

