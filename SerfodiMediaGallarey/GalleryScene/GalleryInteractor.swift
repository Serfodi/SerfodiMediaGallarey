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
    var photo: Photo? { get set }
}

// MARK: Repository

actor PhotoRepository {
    private var photos: [Photo]?
    
    func setPhotos(_ photos: [Photo]?) {
        self.photos = photos
    }
    
    func get() -> [Photo]? { photos }
}

// MARK: Interactor

class GalleryInteractor: GalleryBusinessLogic, GalleryDataStore {
    var presenter: GalleryPresentationLogic?
    var worker: GalleryWorker!
    
    // MARK: Data
    var photoRepository = PhotoRepository()
    // data for detail photo VC
    var photo: Photo?
    
    // MARK: Do something
    
    func doSomething(request: Gallery.Something.Request) {
        if worker === nil { worker = GalleryWorker() }
        
        switch request {
        case .search(parameters: let parameters):
            Task(priority: .userInitiated) {
                do {
                    await photoRepository.setPhotos(try await worker.getPhotos(parameters: parameters))
                    self.presenter?.presentSomething(response: .responseMedia(media: await photoRepository.get()))
                } catch {
                    self.presenter?.presentSomething(response: .responseError(error))
                }
            }
        case .changeGrid:
            Task {
                self.presenter?.presentSomething(response: .responseChangeGrid(media: await photoRepository.get()))
            }
        case .orderBy:
            Task {
                self.presenter?.presentSomething(response: .responseOrderBy(media: await photoRepository.get()))
            }
        case .sortedValue(let sorted):
            Task {
                self.presenter?.presentSomething(response: .responseSortedValue(media: await photoRepository.get() , sortedValue: sorted))
            }
        case .getPhoto(id: let id):
            Task {
                let item = await photoRepository.get()!.first(where: { $0.id == id })!
                self.photo = item
                self.presenter?.presentSomething(response: .responseMediaItem)
            }
        }
    }
}
