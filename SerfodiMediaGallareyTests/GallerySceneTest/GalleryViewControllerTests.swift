//
//  GalleryViewControllerTests.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 06.09.2024.
//

@testable import SerfodiMediaGallarey
import XCTest

class GalleryViewControllerTests: XCTestCase {
    // MARK: Subject under test
    
    var sut: GalleryViewController!
    var window: UIWindow!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupGalleryViewController()
    }
    
    override func tearDown() {
        window = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupGalleryViewController() {
        sut =  GalleryViewController()
    }
    
    
    // MARK: Test doubles
    
    class GalleryBusinessLogicSpy: GalleryBusinessLogic {
        var doSomethingCalled = false
        
        func doSomething(request: Gallery.Something.Request) {
            doSomethingCalled = true
        }
    }
    
    // MARK: Tests
    
    func testShouldDoSomethingWhenViewIsLoaded() {
        let config = Configuration(query: "1")
        
        let spy = GalleryBusinessLogicSpy()
        sut.interactor = spy
        sut.interactor?.doSomething(request: .search(parameters: config))
        
        XCTAssertTrue(spy.doSomethingCalled, "viewDidLoad() should ask the interactor to do something")
    }
    
    func testDisplaySomething() async {
        let cell:[MediaCellModel] = [.init(id: "1", imageURL: "", description: "boo", imageAvatar: "", name: "foo")]
        let viewModel = Gallery.Something.ViewModel.displayMedia(items: cell)
        await sut.displaySomething(viewModel: viewModel)
        let one = await sut.dataSource.mediaItems.count
        XCTAssert(one == 1)
    }
    
}
