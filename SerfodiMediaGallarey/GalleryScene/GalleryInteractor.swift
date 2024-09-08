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

protocol GalleryDataStore {}

// MARK: Repository

actor PhotoRepository {
    private var photos: [Photo]?
    
    func setPhoto(_ photos: [Photo]) {
        self.photos = photos
    }
    
    func get() -> [Photo] {
        photos ?? []
    }
}

// MARK: Interactor

class GalleryInteractor: GalleryBusinessLogic, GalleryDataStore {
    var presenter: GalleryPresentationLogic?
    var worker: GalleryWorker!
    
    // MARK: Data
    var photoRepository = PhotoRepository()
    
    // MARK: Do something
    
    func doSomething(request: Gallery.Something.Request) {
        if worker === nil { worker = GalleryWorker() }
        
        switch request {
        case .search(parameters: let parameters):
            Task(priority: .userInitiated) {
                do {
                    await photoRepository.setPhoto(try await worker.getPhoto(parameters: parameters))
                    self.presenter?.presentSomething(response: .presentMediaItems(media: await photoRepository.get()))
                } catch {
                    self.presenter?.presentSomething(response: .responseError(error))
                }
            }
        case .changeGrid(display: let display):
            Task {
                self.presenter?.presentSomething(response: .presentMediaItems(media: await photoRepository.get(), display: display))
            }
        }
    }
}
