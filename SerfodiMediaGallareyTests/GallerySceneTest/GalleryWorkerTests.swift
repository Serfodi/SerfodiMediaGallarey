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
        sut = GalleryWorker()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
        
    // MARK: Test doubles
    
    // MARK: Tests
    
    func testSomething() async throws {
        // Given
        let config = Configuration(query: "1")
        // When
        let data = try await sut.getPhoto(parameters: config)
        
        // Then
        XCTAssert(data.count > 0)
    }
}
