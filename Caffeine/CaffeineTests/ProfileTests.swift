//
//  ProfileTests.swift
//  CaffeineTests
//
//  Created by Daniel Dluzhnevsky on 2020-04-14.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import XCTest
@testable import Caffeine

class ProfileTests: XCTestCase {
    public func testProfileInitializer() {
        let userReservationView: UIView = UserReservationView()
        
        let profile = Profile(contentView: userReservationView)
        
        XCTAssertEqual(profile.contentView, userReservationView)
    }
    
    public func testFullNameTitleText() {
        let viewModel = ProfileViewModel()
        let expectedResult = "Vardenis Pavardenis"
        
        XCTAssertEqual(viewModel.fullNameTitle, expectedResult)
    }
    
    public func testFirstButtonTitleText() {
        let viewModel = ProfileViewModel()
        let expectedResult = "Rezervacijos"
        
        XCTAssertEqual(viewModel.firstButtonTitle, expectedResult)
    }
    
    public func testSecondButtonTitleText() {
        let viewModel = ProfileViewModel()
        let expectedResult = "Pokalbio temos"
        
        XCTAssertEqual(viewModel.secondButtonTitle, expectedResult)
    }
    
    public func testThirdButtonTitleText() {
        let viewModel = ProfileViewModel()
        let expectedResult = "Informacija"
        
        XCTAssertEqual(viewModel.thirdButtonTitle, expectedResult)
    }
}
