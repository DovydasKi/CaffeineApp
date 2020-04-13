//
//  RegistrationImageSelectionViewModelTests.swift
//  CaffeineTests
//
//  Created by Dovydas Kiriliauskas on 2020-04-13.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import XCTest
@testable import Caffeine

class RegistrationImageSelectionViewModelTests: XCTestCase {
	private static let skipButtonTitle = "Praleisti"
	private static let chooseButtonTitle = "Pasirinkti"
	private static let chooseAcountPhotoText = "Išsirinkite paskyros nuotrauką"
	
	public func testSkipButtonTitle() {
		let viewModel = RegistrationImageSelectionViewModel()
		let expectedResult = "Praleisti"
		
		XCTAssertEqual(viewModel.skipButtonTitle, expectedResult)
	}
	
	public func testchooseButtonTitle() {
		let viewModel = RegistrationImageSelectionViewModel()
		let expectedResult = "Pasirinkti"
		
		XCTAssertEqual(viewModel.chooseButtonTitle, expectedResult)
	}
	
	public func testChooseAcountPhotoText() {
		let viewModel = RegistrationImageSelectionViewModel()
		let expectedResult = "Išsirinkite paskyros nuotrauką"
		
		XCTAssertEqual(viewModel.chooseAcountPhotoText, expectedResult)
	}
}
