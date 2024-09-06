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
        var presentSomethingCalled = false
        
        func presentSomething(response: Gallery.Something.Response) {
            presentSomethingCalled = true
        }
    }
    
    // MARK: Tests
    
    func testDoSomething() {
        // Given
        let spy = GalleryPresentationLogicSpy()
        sut.presenter = spy
        //    let request = Gallery.Something.Request()
        
        // When
        //    sut.doSomething(request: request)
        
        // Then
        XCTAssertTrue(spy.presentSomethingCalled, "doSomething(request:) should ask the presenter to format the result")
    }
}
