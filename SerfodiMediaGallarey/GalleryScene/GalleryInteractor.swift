//
//  GalleryInteractor.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 06.09.2024.
//

import UIKit

protocol GalleryBusinessLogic {
    func doSomething(request: Gallery.Something.Request)
}

protocol GalleryDataStore {
    //var name: String { get set }
}

class GalleryInteractor: GalleryBusinessLogic, GalleryDataStore {
    var presenter: GalleryPresentationLogic?
    var worker: GalleryWorker!
    
    // MARK: Do something
    
    func doSomething(request: Gallery.Something.Request) {
        if worker === nil { worker = GalleryWorker() }
        
        switch request {
        case .search(parameters: let parameters):
            Task(priority: .userInitiated) {
                do {
                    let items = try await worker.getPhoto(parameters: parameters)
                    self.presenter?.presentSomething(response: .presentMediaItems(media: items))
                } catch {
                    self.presenter?.presentSomething(response: .responseError(error))
                }
            }
        }
    }
    
}
