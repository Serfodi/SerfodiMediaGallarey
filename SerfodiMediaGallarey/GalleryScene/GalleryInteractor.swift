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
    private var photos: [Photo] = []
    
    func setPhotos(_ photos: [Photo]) {
        self.photos = photos
    }
    
    func add(_ new: [Photo]) {
        photos += new
    }
    
    func get() -> [Photo] { photos }
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
            self.presenter?.presentSomething(response: .presentLoader)
            Task(priority: .userInitiated) {
                do {
                    let photos = try await worker.getPhotos(parameters: parameters)
                    await photoRepository.setPhotos(photos)
                    self.presenter?.presentSomething(response: .presentPhotos(photos: await photoRepository.get()))
                } catch {
                    self.presentError(error: error, await photoRepository.get().isEmpty)
                }
            }
        case .refreshPage:
            Task(priority: .userInitiated) {
                do {
                    let photos = try await worker.getFirstPage()
                    await photoRepository.setPhotos(photos)
                    self.presenter?.presentSomething(response: .presentRefreshPhotos(photos: photos))
                } catch {
                    self.presentError(error: error, await photoRepository.get().isEmpty)
                }
            }
        case .loadPage:
            self.presenter?.presentSomething(response: .presentFooterLoader)
            Task(priority: .userInitiated) {
                do {
                    let new = try await worker.getNewPhotos()
                    await photoRepository.add(new)
                    let photos = await photoRepository.get()
                    self.presenter?.presentSomething(response: .presentNewPhotos(photos: photos))
                } catch {
                    self.presentError(error: error, await photoRepository.get().isEmpty)
                }
            }
        case .changeGrid:
            Task {
                let photos = await photoRepository.get()
                self.presenter?.presentSomething(response: .presentChangeGrid(photos: photos))
            }
        case .orderBy:
            Task {
                let photos = await photoRepository.get()
                self.presenter?.presentSomething(response: .presentOrderBy(photos: photos))
            }
        case .sortedValue(let sorted):
            Task {
                let photos = await photoRepository.get()
                self.presenter?.presentSomething(response: .presentSortedValue(photos: photos, sortedValue: sorted))
            }
        case .getPhoto(id: let id):
            Task {
                self.photo = await photoRepository.get().first(where: { $0.id == id })!
                self.presenter?.presentSomething(response: .presentSelectedPhoto)
            }
        }
    }
    
    // MARK: Helpers
    
    func presentError(error: Error, _ isEmpty: Bool) {
        if isEmpty {
            self.presenter?.presentSomething(response: .presentError(error))
        } else {
            self.presenter?.presentSomething(response: .presentErrorAlert(error))
        }
    }
    
}
