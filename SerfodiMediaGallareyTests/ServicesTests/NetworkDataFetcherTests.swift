//
//  NetworkDataFetcherTests.swift
//  SerfodiMediaGallareyTests
//
//  Created by Сергей Насыбуллин on 06.09.2024.
//

import XCTest
@testable import SerfodiMediaGallarey

final class NetworkDataFetcherTests: XCTestCase {

    var sut: NetworkDataFetcher!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = NetworkDataFetcher(networking: NetworkService())
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testGetPhotoFromNetworking() async throws {
        let parameters = ["query":"office"]
        let data = try await sut.getPhoto(parameters: parameters)
        XCTAssertNotNil(data)
    }
    
}


