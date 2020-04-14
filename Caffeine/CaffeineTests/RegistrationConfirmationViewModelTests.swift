//
//  RegistrationConfirmationViewModelTests.swift
//  CaffeineTests
//
//  Created by Daniel Dluzhnevsky on 2020-04-14.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import XCTest
@testable import Caffeine

class RegistrationConfirmationViewModelTests: XCTestCase {
    public func testCaffeineLabelTitleText() {
        let viewModel = RegistrationConfirmationViewModel()
        let expectedResult = "Caffeine"
        
        XCTAssertEqual(viewModel.caffeineLabelTitle, expectedResult)
    }
    
    public func testConfirmationLabelTitleText() {
        let viewModel = RegistrationConfirmationViewModel()
        let expectedResult = "Patvirtinkite el.pašto adresą"
        
        XCTAssertEqual(viewModel.confirmationLabelTitle, expectedResult)
    }
}

