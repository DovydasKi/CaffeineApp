//
//  TabBarViewModelTests.swift
//  CaffeineTests
//
//  Created by Daniel Dluzhnevsky on 2020-04-14.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import XCTest
@testable import Caffeine

class TabBarViewModelTests: XCTestCase {
    public func testProfileViewControllerTitleText() {
        let viewModel = TabBarViewModel()
        let expectedResult = "Profilis"

        XCTAssertEqual(viewModel.profileViewControllerTitle, expectedResult)
    }

    public func testRestaurantMapViewControllerTitleText() {
        let viewModel = TabBarViewModel()
        let expectedResult = "Kavinės"

        XCTAssertEqual(viewModel.restaurantMapViewControllerTitle, expectedResult)
    }

    public func testReservationViewControllerTitleText() {
        let viewModel = TabBarViewModel()
        let expectedResult = "Rezervacija"

        XCTAssertEqual(viewModel.reservationViewControllerTitle, expectedResult)
    }
}
