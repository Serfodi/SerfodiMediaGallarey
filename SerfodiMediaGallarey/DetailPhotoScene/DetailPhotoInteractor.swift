//
//  DetailPhotoInteractor.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 08.09.2024.
//

import UIKit

protocol DetailPhotoBusinessLogic {
    func doSomething(request: DetailPhoto.Something.Request)
}

protocol DetailPhotoDataStore {}

class DetailPhotoInteractor: DetailPhotoBusinessLogic, DetailPhotoDataStore {
    var presenter: DetailPhotoPresentationLogic?
    var worker: DetailPhotoWorker?
    
    // MARK: Do something
    
    func doSomething(request: DetailPhoto.Something.Request) {
        
        
        
    }
    
}
