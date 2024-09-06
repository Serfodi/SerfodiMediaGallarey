//
//  GalleryPresenterTests.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 06.09.2024.
//

@testable import SerfodiMediaGallarey
import XCTest

class GalleryPresenterTests: XCTestCase {
    // MARK: Subject under test
    
    var sut: GalleryPresenter!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupGalleryPresenter()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupGalleryPresenter() {
        sut = GalleryPresenter()
    }
    
    // MARK: Test doubles
    
    class GalleryDisplayLogicSpy: GalleryDisplayLogic {
        
        var items = [MediaCellModel]()
        var error: String? = nil
        
        func displaySomething(viewModel: Gallery.Something.ViewModel) {
            switch viewModel {
            case .displayMedia(items: let items):
                self.items = items
            case .displayError(let error):
                self.error = error
                print(#function, error)
            }
        }
    }
    
    // MARK: Tests
    
    func testPresentSomething() async throws {
        // Given
        let spy = GalleryDisplayLogicSpy()
        let photo = Photo()
        
        sut.viewController = spy
        let response = Gallery.Something.Response.presentMediaItems(media: [photo])
        
        // When
        sut.presentSomething(response: response)
        
        try await Task.sleep(nanoseconds: 2)
        
        XCTAssertEqual(spy.items.count, 1)
    }
    
    
    
}

fileprivate extension Photo {
    
    init() {
        self.init(id: "foo", createdAt: "boo", description: nil, user: User(id: "", username: "", profileImage: nil), links: .init(download: ""), urls: .init(regular: ""))
    }
    
}
