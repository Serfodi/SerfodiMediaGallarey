//
//  DetailPhotoPresenter.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 08.09.2024.
//
import UIKit

protocol DetailPhotoPresentationLogic {
    func presentSomething(response: DetailPhoto.Something.Response)
}

class DetailPhotoPresenter: DetailPhotoPresentationLogic {
    weak var viewController: DetailPhotoDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(response: DetailPhoto.Something.Response) {
        
    }
    
}
