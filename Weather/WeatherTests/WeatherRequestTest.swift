//
//  WeatherRequestTest.swift
//  WeatherTests
//
//  Created by Brahmbhatt, Parth (P.) on 10/6/24.
//

import XCTest
@testable import Weather

class WeatherRequestTest: XCTestCase {

    var systemUnderTest: WeatherRequest!
    
    override func setUp() {
        let params = ["q": "USA", "appid": Environment.API_KEY]
        systemUnderTest = WeatherRequest(params)
    }

    override func tearDown() {}

    func testRequestInitialization() {
        let items = systemUnderTest.queryParams.map{
            URLQueryItem(name: $0.0, value: $0.1)
        }
        XCTAssertEqual(systemUnderTest.queryItems, items)
    }

    func testPerformanceExample() {
        self.measure {}
    }
}
