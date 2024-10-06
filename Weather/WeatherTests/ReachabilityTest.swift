//
//  ReachabilityTest.swift
//  WeatherTests
//
//  Created by Brahmbhatt, Parth (P.) on 10/6/24.
//

import XCTest
@testable import Weather

class ReachabilityTest: XCTestCase {

    override func setUp() {}

    override func tearDown() {}

    func testReachabilitySuccess() {
        XCTAssertEqual(Reachability.isConnectedToNetwork, true)
    }

    func testPerformanceExample() {
        self.measure {}
    }

}
