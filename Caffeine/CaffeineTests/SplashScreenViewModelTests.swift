//
//  SplashScreenViewModelTests.swift
//  CaffeineTests
//
//  Created by Daniel Dluzhnevsky on 2020-04-14.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import XCTest
@testable import Caffeine

class SplashScreenViewModelTests: XCTestCase {
    public func testCaffeineLabelTitleText() {
        let viewModel = SplashScreenViewModel()
        let expectedResult = "Caffeine"
        
        XCTAssertEqual(viewModel.caffeineLabelTitle, expectedResult)
    }
}
