//
//  RegisterViewModelTests.swift
//  CaffeineTests
//
//  Created by Dovydas Kiriliauskas on 2020-04-13.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import XCTest
@testable import Caffeine

class RegisterViewModelTests: XCTestCase {
	
	public func testSignupTitleText() {
		let viewModel = RegisterViewModel()
		let expectedResult = "Registracija"
		
		XCTAssertEqual(viewModel.signupTitleText, expectedResult)
	}
	
	public func testFullNameTextFieldPlaceholderText() {
		let viewModel = RegisterViewModel()
		let expectedResult = "Vardas Pavardė"
		
		XCTAssertEqual(viewModel.fullNameTextFieldPlaceholderText, expectedResult)
	}
	
	public func testUserNameTextFieldPlaceholderText() {
		let viewModel = RegisterViewModel()
		let expectedResult = "Naudotojo vardas"
		
		XCTAssertEqual(viewModel.userNameTextFieldPlaceholderText, expectedResult)
	}
	
	public func testEmailTextFieldPlaceholderText() {
		let viewModel = RegisterViewModel()
		let expectedResult = "El.paštas"
		
		XCTAssertEqual(viewModel.emailTextFieldPlaceholderText, expectedResult)
	}
	
	public func testPasswordTextFieldPlaceholderText() {
		let viewModel = RegisterViewModel()
		let expectedResult = "Slaptažodis"
		
		XCTAssertEqual(viewModel.passwordTextFieldPlaceholderText, expectedResult)
	}
	
	public func testPasswordRequirementText() {
		let viewModel = RegisterViewModel()
		let expectedResult = "5 simboliai slaptažodyje"
		
		XCTAssertEqual(viewModel.passwordRequirementText, expectedResult)
	}
	
	public func testCreateAccountButtonTitleText() {
		let viewModel = RegisterViewModel()
		let expectedResult = "Sukurti paskyrą"
		
		XCTAssertEqual(viewModel.createAccountButtonTitleText, expectedResult)
	}
	
	public func testDislaimerText() {
		let viewModel = RegisterViewModel()
		let expectedResult = "Sukurdami paskyrą sutinkate su mūsų paslaugų tiekimo ir privatumo politika"
		
		XCTAssertEqual(viewModel.dislaimerText, expectedResult)
	}
	
	public func testAlertTitleText() {
		let viewModel = RegisterViewModel()
		let expectedResult = "Klaida!"
		
		XCTAssertEqual(viewModel.alertTitleText, expectedResult)
	}
	
	public func testAlertMessageText() {
		let viewModel = RegisterViewModel()
		let expectedResult = "Neteisingas El.paštas"
		
		XCTAssertEqual(viewModel.alertMessageText, expectedResult)
	}
	
	public func testCheckAllValidFieldsWhenFullNameFieldIsValid() {
		let viewModel = RegisterViewModel()
		
		let fullName = UITextField()
		fullName.text = "fullName"
		
		let userName = UITextField()
		let email = UITextField()
		let password = UITextField()

		XCTAssertFalse(viewModel.checkForAllValidFields(fullNameField: fullName, userNameField: userName, emailField: email, passwordField: password))
	}
	
	public func testCheckAllValidFieldsWhenUserNameFieldIsValid() {
		let viewModel = RegisterViewModel()
		
		let fullName = UITextField()
		
		let userName = UITextField()
		userName.text = "UserName"
		
		let email = UITextField()
		let password = UITextField()

		XCTAssertFalse(viewModel.checkForAllValidFields(fullNameField: fullName, userNameField: userName, emailField: email, passwordField: password))
	}
	
	public func testCheckAllValidFieldsWhenEmailFieldIsValid() {
		let viewModel = RegisterViewModel()
		
		let fullName = UITextField()
		let userName = UITextField()
		
		let email = UITextField()
		email.text = "email@email.lt"
		
		let password = UITextField()

		XCTAssertFalse(viewModel.checkForAllValidFields(fullNameField: fullName, userNameField: userName, emailField: email, passwordField: password))
	}
	
	public func testCheckAllValidFieldsWhenPasswordFieldIsValid() {
		let viewModel = RegisterViewModel()
		
		let fullName = UITextField()
		let userName = UITextField()
		let email = UITextField()
		
		let password = UITextField()
		password.text = "password"
		XCTAssertFalse(viewModel.checkForAllValidFields(fullNameField: fullName, userNameField: userName, emailField: email, passwordField: password))
	}
	
	public func testCheckAllValidFieldsWhenPasswordFieldAndEmailFieldAreValid() {
		let viewModel = RegisterViewModel()
		
		let fullName = UITextField()
		let userName = UITextField()
		
		let email = UITextField()
		email.text = "email@email.lt"
		
		let password = UITextField()
		password.text = "password"
		XCTAssertFalse(viewModel.checkForAllValidFields(fullNameField: fullName, userNameField: userName, emailField: email, passwordField: password))
	}
	
	public func testCheckAllValidFieldsWhenAllFieldsAreValid() {
		let viewModel = RegisterViewModel()
		
		let fullName = UITextField()
		fullName.text = "FullName"
		
		let userName = UITextField()
		userName.text = "UserName"
		
		let email = UITextField()
		email.text = "email@email.lt"
		
		let password = UITextField()
		password.text = "password"
		XCTAssertTrue(viewModel.checkForAllValidFields(fullNameField: fullName, userNameField: userName, emailField: email, passwordField: password))
	}
}
