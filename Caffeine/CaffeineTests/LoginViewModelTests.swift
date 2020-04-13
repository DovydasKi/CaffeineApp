//
//  LoginViewModelTests.swift
//  CaffeineTests
//
//  Created by Dovydas Kiriliauskas on 2020-04-11.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import XCTest
@testable import Caffeine

class LoginViewModelTests: XCTestCase {
	
	public func testLoginTitleText() {
		let viewModel = LoginViewModel()
		let expectedResult = "Prisijungimas"
		
		XCTAssertEqual(viewModel.loginTitle, expectedResult)
	}
	
	public func testLoginButtonTitleText() {
		let viewModel = LoginViewModel()
		let expectedResult = "Prisijungti"
		
		XCTAssertEqual(viewModel.loginButtonTitle, expectedResult)
	}
	
	public func testEmailTitleText() {
		let viewModel = LoginViewModel()
		let expectedResult = "El.paštas"
		
		XCTAssertEqual(viewModel.emailTitle, expectedResult)
	}
	
	public func testPasswordTitleText() {
		let viewModel = LoginViewModel()
		let expectedResult = "Slaptažodis"
		
		XCTAssertEqual(viewModel.passwordTitle, expectedResult)
	}
	
	public func testDontHaveAccountTitleText() {
		let viewModel = LoginViewModel()
		let expectedResult = "Neturite paskyros?\nUžsiregistruokite!"
		
		XCTAssertEqual(viewModel.dontHaveAccountTitle, expectedResult)
	}
	
	public func testForgotPasswordTitleText() {
		let viewModel = LoginViewModel()
		let expectedResult = "Pamiršote slaptažodį?"
		
		XCTAssertEqual(viewModel.forgotPasswordTitle, expectedResult)
	}
	
	public func testIncorrectPasswordText() {
		let viewModel = LoginViewModel()
		let expectedResult = "Neteisingas El.paštas arba slaptažodis"
		
		XCTAssertEqual(viewModel.incorrectPasswordText, expectedResult)
	}
	
	public func testAllFieldsValidationWhenOnlyEmailFieldIsValid() {
		let viewModel = LoginViewModel()
		
		let emailField = UITextField()
		emailField.text = "email@email.lt"
		
		let passwordField = UITextField()
		
		XCTAssertFalse(viewModel.checkForAllValidFields(emailField: emailField, passwordField: passwordField))
	}
	
	public func testAllFieldsValidationWhenOnlyPasswordFieldIsValid() {
		let viewModel = LoginViewModel()
		
		let emailField = UITextField()
		
		let passwordField = UITextField()
		passwordField.text = "123456"
		
		XCTAssertFalse(viewModel.checkForAllValidFields(emailField: emailField, passwordField: passwordField))
	}
	
	public func testAllFieldsValidationWhenBothFieldsAreValid() {
		let viewModel = LoginViewModel()
		
		let emailField = UITextField()
		emailField.text = "email@email.lt"
		
		let passwordField = UITextField()
		passwordField.text = "123456"
		
		XCTAssertTrue(viewModel.checkForAllValidFields(emailField: emailField, passwordField: passwordField))
	}
}
