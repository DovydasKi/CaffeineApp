//
//  ReservationDetailsViewModelTests.swift
//  CaffeineTests
//
//  Created by Dovydas Kiriliauskas on 2020-04-13.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import XCTest
@testable import Caffeine

class ReservationDetailsViewModelTests: XCTestCase {
	public func testTitleText() {
		let viewModel = ReservationDetailsViewModel(type: .withCompanion)
		let expectedResult = "CAFFEINE"
		
		XCTAssertEqual(viewModel.titleText, expectedResult)
	}
	
	public func testCafeText() {
		let viewModel = ReservationDetailsViewModel(type: .withCompanion)
		let expectedResult = "Kavinė"
		
		XCTAssertEqual(viewModel.cafeText, expectedResult)
	}
	
	public func testChooseButtonText() {
		let viewModel = ReservationDetailsViewModel(type: .withCompanion)
		let expectedResult = "Pasirinkti"
		
		XCTAssertEqual(viewModel.chooseButtonText, expectedResult)
	}
	
	public func testDatePlaceholderText() {
		let viewModel = ReservationDetailsViewModel(type: .withCompanion)
		let expectedResult = "Laikas"
		
		XCTAssertEqual(viewModel.datePlaceholderText, expectedResult)
	}
	
	public func testSaveButtonText() {
		let viewModel = ReservationDetailsViewModel(type: .withCompanion)
		let expectedResult = "Išsaugoti"
		
		XCTAssertEqual(viewModel.saveButtonText, expectedResult)
	}
	
	public func testGuestsAmmountText() {
		let viewModel = ReservationDetailsViewModel(type: .withCompanion)
		let expectedResult = "Svečių kiekis"
		
		XCTAssertEqual(viewModel.guestsAmmountText, expectedResult)
	}
	
	public func testConversationThemeText() {
		let viewModel = ReservationDetailsViewModel(type: .withCompanion)
		let expectedResult = "Pokalbio tema"
		
		XCTAssertEqual(viewModel.conversationThemeText, expectedResult)
	}
	
	public func testCompanionSerachText() {
		let viewModel = ReservationDetailsViewModel(type: .withCompanion)
		let expectedResult = "Pašnekovo paieška"
		
		XCTAssertEqual(viewModel.companionSearchText, expectedResult)
	}
	
	public func testReservationWithCompanionTitle() {
		let viewModel = ReservationDetailsViewModel(type: .withCompanion)
		let expectedResult = "Rezervacija su pašnekovu"
		
		XCTAssertEqual(viewModel.reservationWithCompanionTitle, expectedResult)
	}
	
	public func testReservationWithoutCompanionTitle() {
		let viewModel = ReservationDetailsViewModel(type: .withCompanion)
		let expectedResult = "Rezervacija be pašnekovo"
		
		XCTAssertEqual(viewModel.reservationWithoutCompanionTitle, expectedResult)
	}
	
	public func testCafeAddressesArrayValues() {
		let viewModel = ReservationDetailsViewModel(type: .withCompanion)
		let firstExpectedResult = "Vilniaus g. 7"
		let secondExpectedResult = "Gedimino pr. 2"
		let thirdExpectedResult = "Saulėtekio al. 15"
		
		XCTAssertEqual(viewModel.cafeAddresses.first, firstExpectedResult)
		XCTAssertEqual(viewModel.cafeAddresses[2], secondExpectedResult)
		XCTAssertEqual(viewModel.cafeAddresses.last, thirdExpectedResult)
	}
	
	public func testGuestsAmmountArrayValues() {
		let viewModel = ReservationDetailsViewModel(type: .withCompanion)
		
		XCTAssertEqual(viewModel.guestsAmmount.first, 1)
		XCTAssertEqual(viewModel.guestsAmmount.last, 10)
		XCTAssertEqual(viewModel.guestsAmmount[7], 8)
	}
	
	public func testTitleLabelWhenReservationTypeIsWithCompanion() {
		let viewModel = ReservationDetailsViewModel(type: .withCompanion)
		let expectedResult = "Rezervacija su pašnekovu"
		
		let result = viewModel.titleLabelText()
		
		XCTAssertEqual(result, expectedResult)
	}
	
	public func testTitleLabelWhenReservationTypeIsWithoutCompanion() {
		let viewModel = ReservationDetailsViewModel(type: .withoutCompanion)
		let expectedResult = "Rezervacija be pašnekovo"
		
		let result = viewModel.titleLabelText()
		
		XCTAssertEqual(result, expectedResult)
	}
	
	public func testTitleLabelWhenReservationTypeIsOther() {
		let viewModel = ReservationDetailsViewModel(type: .other)
		let expectedResult = "Pašnekovo paieška"
		
		let result = viewModel.titleLabelText()
		
		XCTAssertEqual(result, expectedResult)
	}
}
