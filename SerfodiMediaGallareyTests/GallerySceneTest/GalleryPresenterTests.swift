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
        var displaySomethingCalled = false
        
        func displaySomething(viewModel: Gallery.Something.ViewModel) {
            displaySomethingCalled = true
        }
    }
    
    // MARK: Tests
    
    func testPresentSomething() {
        // Given
        let spy = GalleryDisplayLogicSpy()
        sut.viewController = spy
        let response = Gallery.Something.Response.self
        
        // When
        //    sut.presentSomething(response: response)
        
        // Then
        XCTAssertTrue(spy.displaySomethingCalled, "presentSomething(response:) should ask the view controller to display the result")
    }
}
