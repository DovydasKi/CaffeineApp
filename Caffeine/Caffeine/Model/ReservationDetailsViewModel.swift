//
//  ReservationDetailsViewModel.swift
//  Caffeine
//
//  Created by Dovydas Kiriliauskas on 2020-03-25.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation

class ReservationDetailsViewModel {
	
	enum ReservationFlowType {
		case withCompanion
		case withoutCompanion
		case other
	}
	
	public let reservationType: ReservationFlowType
	private static let titleText = "CAFFEINE"
	private static let cafeText = "Kavinė"
	private static let chooseButtonText = "Pasirinkti"
	private static let datePlaceholderText = "Laikas"
	private static let saveButtonText = "Išsaugoti"
	private static let guestsAmmountText = "Svečių kiekis"
	private static let conversationThemeText = "Pokalbio tema"
	private static let companionSerachText = "Pašnekovo paieška"
	private static let reservationWithCompanionTitle: String = "Rezervacija su pašnekovu"
	private static let reservationWithoutCompanionTitle: String = "Rezervacija be pašnekovo"
	
	private static let cafeAddresses: [String] = ["Vilniaus g. 7", "Ulonų g. 5", "Gedimino pr. 2", "Pilies g. 3", "Saulėtekio al. 15"]
	private static let guestsAmmount: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

	init(type: ReservationFlowType) {
		self.reservationType = type
	}
	
	public func titleLabelText() -> String {
		if self.reservationType == .withCompanion {
			return self.reservationWithCompanionTitle
		} else if self.reservationType == .withoutCompanion {
			return self.reservationWithoutCompanionTitle
		} else {
			return self.companionSearchText
		}
	}
}

extension ReservationDetailsViewModel {
	public var reservationWithCompanionTitle: String {
		return type(of: self).reservationWithCompanionTitle
	}
	
	public var reservationWithoutCompanionTitle: String {
		return type(of: self).reservationWithoutCompanionTitle
	}
	
	public var titleText: String {
		type(of: self).titleText
	}
	
	public var companionSearchText: String {
		type(of: self).companionSerachText
	}
	
	public var chooseButtonText: String {
		type(of: self).chooseButtonText
	}
	
	public var datePlaceholderText: String {
		type(of: self).datePlaceholderText
	}
	
	public var conversationThemeText: String {
		type(of: self).conversationThemeText
	}
	
	public var saveButtonText: String {
		type(of: self).saveButtonText
	}
	
	public var cafeAddresses: [String] {
		type(of: self).cafeAddresses
	}
	
	public var guestsAmmount: [Int] {
		type(of: self).guestsAmmount
	}
	
	public var guestsAmmountText: String {
		type(of: self).guestsAmmountText
	}
	
	public var cafeText: String {
		type(of: self).cafeText
	}
}
