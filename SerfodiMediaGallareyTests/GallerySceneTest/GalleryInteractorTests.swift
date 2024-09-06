//
//  GalleryInteractorTests.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 06.09.2024.
//

@testable import SerfodiMediaGallarey
import XCTest

class GalleryInteractorTests: XCTestCase {
    // MARK: Subject under test
    
    var sut: GalleryInteractor!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupGalleryInteractor()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupGalleryInteractor() {
        sut = GalleryInteractor()
    }
    
    // MARK: Test doubles
    
    class GalleryPresentationLogicSpy: GalleryPresentationLogic {
        var media: [Photo]? = nil
        var error: Error? = nil
        
        func presentSomething(response: Gallery.Something.Response) {
            switch response {
            case .presentMediaItems(media: let media):
                self.media = media
            case .responseError(let error):
                self.error = error
            }
        }
    }
    
    // MARK: Tests
    
//    func testDoSomething() async throws {
//        let config = Configuration(query: "Forest")
//        let spy = GalleryPresentationLogicSpy()
//        sut.presenter = spy
//        
//        let request = Gallery.Something.Request.search(parameters: config)
//        
//        sut.doSomething(request: request)
//        
//        try await Task.sleep(nanoseconds: 2)
//        
//        XCTAssert(spy.media?.count == 10)
//    }
    
    
}
