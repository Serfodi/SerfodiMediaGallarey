//
//  NetworkServiceTests.swift
//  SerfodiMediaGallareyTests
//
//  Created by Сергей Насыбуллин on 06.09.2024.
//

import XCTest
@testable import SerfodiMediaGallarey

final class NetworkServiceTests: XCTestCase {

    var sut: Networking!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = NetworkService()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testGetDataFromNetworking() async throws {
        let parameters = ["query":"office"]
        let path = API.photosPath
        let data = try await sut.request(path: path, params: parameters)
        XCTAssertNotNil(data)
    }

    func testBadRequestGetDataFromNetworking() async {
        let path = API.photosPath
        do {
            let data = try await sut.request(path: path, params: [:])
            XCTAssertNotNil(data)
        } catch HTTPStatusCode.badRequest {
            XCTAssert(true)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
}
