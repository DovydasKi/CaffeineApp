//
//  MainScreenViewModelTests.swift
//  CaffeineTests
//
//  Created by Daniel Dluzhnevsky on 2020-04-14.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import XCTest
@testable import Caffeine

class MainScreenViewModelTests: XCTestCase {
    public func testCaffeineLabelTitleText() {
        let viewModel = MainScreenViewModel()
        let expectedResult = "Caffeine"
        
        XCTAssertEqual(viewModel.caffeineLabelTitle, expectedResult)
    }
    
    public func testLoginButtonTitleText() {
        let viewModel = MainScreenViewModel()
        let expectedResult = "Prisijungti"
        
        XCTAssertEqual(viewModel.loginButtonTitle, expectedResult)
    }
    
    public func testGetStartedButtonTitleText() {
        let viewModel = MainScreenViewModel()
        let expectedResult = "Registruotis"
        
        XCTAssertEqual(viewModel.getStartedButtonTitle, expectedResult)
    }
}
