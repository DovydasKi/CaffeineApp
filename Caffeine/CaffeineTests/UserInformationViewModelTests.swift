//
//  UserInformationViewModelTests.swift
//  CaffeineTests
//
//  Created by Daniel Dluzhnevsky on 2020-04-14.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import XCTest
@testable import Caffeine

class UserInformationViewModelTests: XCTestCase {
    public func testEmailTitleText() {
        let viewModel = UserInformationViewModel()
        let expectedResult = "El. pašto adresas:"
        XCTAssertEqual(viewModel.emailTitleText, expectedResult)
    }
    
    public func testEmailBodyText() {
        let viewModel = UserInformationViewModel()
        let expectedResult = "vardas.pavardenis@stud.vgtu.lt"
        XCTAssertEqual(viewModel.emailBodyText, expectedResult)
    }
    
    public func testUserSinceTitleText() {
        let viewModel = UserInformationViewModel()
        let expectedResult = "Akyvus nuo:"
        XCTAssertEqual(viewModel.userSinceTitleText, expectedResult)
    }
    
    public func testUserSinceBodyText() {
        let viewModel = UserInformationViewModel()
        let expectedResult = "2020-02-25"
        XCTAssertEqual(viewModel.userSinceBodyText, expectedResult)
    }
    
    public func testPasswordTitleText() {
        let viewModel = UserInformationViewModel()
        let expectedResult = "Slaptažodis:"
        XCTAssertEqual(viewModel.passwordTitleText, expectedResult)
    }
    
    public func testPasswordBodyText() {
        let viewModel = UserInformationViewModel()
        let expectedResult = "*************"
        XCTAssertEqual(viewModel.passwordBodyText, expectedResult)
    }
    
    public func testLogoutButtonText() {
        let viewModel = UserInformationViewModel()
        let expectedResult = "Atsijungti"
        XCTAssertEqual(viewModel.logoutButtonText, expectedResult)
    }
    
    
}

