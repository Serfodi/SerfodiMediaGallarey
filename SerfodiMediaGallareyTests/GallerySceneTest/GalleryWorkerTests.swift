//
//  GalleryWorkerTests.swift
//  SerfodiMediaGallarey
//
//  Created by Сергей Насыбуллин on 06.09.2024.
//

@testable import SerfodiMediaGallarey
import XCTest

class GalleryWorkerTests: XCTestCase {
    // MARK: Subject under test
    
    var sut: GalleryWorker!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupGalleryWorker()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupGalleryWorker() {
        sut = GalleryWorker()
    }
    
    // MARK: Test doubles
    
    // MARK: Tests
    
    func testSomething() {
        // Given
        
        // When
        
        // Then
    }
}
