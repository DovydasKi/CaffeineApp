//
//  PropertyCardViewModelTests.swift
//  CaffeineTests
//
//  Created by Daniel Dluzhnevsky on 2020-04-14.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import XCTest
@testable import Caffeine

class PropertyCardViewModelTests: XCTestCase {
    public func testMenuButtonTitleText() {
        let viewModel = PropertyCardViewModel()
        let expectedResult = "Kavinės meniu"

        XCTAssertEqual(viewModel.menuButtonTitle, expectedResult)
    }
}
