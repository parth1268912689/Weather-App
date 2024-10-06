//
//  APIServiceErrorTest.swift
//  WeatherTests
//
//  Created by Brahmbhatt, Parth (P.) on 10/6/24.
//

import XCTest
@testable import Weather

class APIServiceErrorTest: XCTestCase {

    let networkErrorTest = APIServiceError.networkError
    
    override func setUp() {}

    override func tearDown() {}
    
    func testAPIServiceError() {
        XCTAssertEqual(networkErrorTest.localizedDescription, "Network Connection Fail.")
    }

    func testPerformanceExample() {
        self.measure {}
    }
}
