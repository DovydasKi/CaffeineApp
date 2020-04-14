//
//  RestaurantsViewModelTests.swift
//  CaffeineTests
//
//  Created by Daniel Dluzhnevsky on 2020-04-14.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import XCTest
@testable import Caffeine

class RestaurantsViewModelTests: XCTestCase {
    public func testCoordinatesArray() {
        let viewModel = RestaurantsViewModel()
        let expectedResult = [
            [54.723452, 25.337927],
            [54.712976, 25.314877],
            [54.714750, 25.298599],
            [54.686098, 25.285147],
            [54.696427, 25.276900]
        ]

        XCTAssertEqual(viewModel.coordinatesArray, expectedResult)
    }

    public func testImage() {
        let viewModel = RestaurantsViewModel()
        let expectedResult = #imageLiteral(resourceName: "sauletekis")

        XCTAssertEqual(viewModel.image, expectedResult)
    }
    
    public func testAddress() {
        let viewModel = RestaurantsViewModel()
        let expectedResult = "Saulėtekio al. 15"

        XCTAssertEqual(viewModel.address, expectedResult)
    }
    
    public func testWorkingHours() {
        let viewModel = RestaurantsViewModel()
        let expectedResult = "I-V 7-22\nVI- VII 9-21"

        XCTAssertEqual(viewModel.workingHours, expectedResult)
    }
}
