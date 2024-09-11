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

protocol DetailPhotoDataStore {
    var photo: Photo! { get set }
    var fullImage: UIImage? { get set }
}

class DetailPhotoInteractor: DetailPhotoBusinessLogic, DetailPhotoDataStore {
    var presenter: DetailPhotoPresentationLogic?
    var worker: DetailPhotoWorker!
    
    var photo: Photo!
    var fullImage: UIImage?
    
    // MARK: Do something
    
    func doSomething(request: DetailPhoto.Something.Request) {
        if worker === nil { worker = DetailPhotoWorker() }
        switch request {
        case .getImage:
            presenter?.presentSomething(response: .responseLoad)
            Task {
                do {
                    let image = try await worker.loadImage(urlString: photo.urls.regular)
                    presenter?.presentSomething(response: .responsePhoto(image: image))
                } catch {
                    presenter?.presentSomething(response: .responseError(error))
                }
            }
            
        case .openInfo:
            
            Task {
                do {
                    let info = try await worker.loadInfo(id: photo.id)
                    self.photo.location = info?.location
                    self.photo.exif = info?.exif
                    presenter?.presentSomething(response: .responseMoreInfo)
                } catch {
                    presenter?.presentSomething(response: .responseError(error))
                }
            }
            
        case .sharedPhoto:
//            presenter?.presentSomething(response: .responseLoad)
            Task {
                do {
                    if self.fullImage == nil {
                        self.fullImage = try await worker.loadImage(urlString: photo.urls.full)
                    }
                    presenter?.presentSomething(response: .responseFullPhoto)
                } catch {
                    presenter?.presentSomething(response: .responseError(error))
                }
            }
            
        case .downloadPhoto:
//            presenter?.presentSomething(response: .responseLoad)
            Task {
                do {
                    if self.fullImage == nil {
                        self.fullImage = try await worker.loadImage(urlString: photo.urls.full)
                    }
                    try await worker.downloadImage(self.fullImage!)
                    presenter?.presentSomething(response: .responseDownloadImage)
                } catch {
                    presenter?.presentSomething(response: .responseErrorDownload)
                }
            }
            
        }
    }
    
}
