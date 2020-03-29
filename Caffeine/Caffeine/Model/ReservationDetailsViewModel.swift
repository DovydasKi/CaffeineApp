//
//  ReservationDetailsViewModel.swift
//  Caffeine
//
//  Created by Dovydas Kiriliauskas on 2020-03-25.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation

class ReservationDetailsViewModel {
	public let reservationType: ReservationFlowType
	public let cafeAddresses: [String] = ["Vilniaus g. 7", "Ulonų g. 5", "Gedimino pr. 2", "Pilies g. 3", "Saulėtekio al. 15"]
	public let guestsAmmount: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
	private static let reservationWithCompanionTitle: String = "Rezervacija su pašnekovu"
	private static let reservationWithoutCompanionTitle: String = "Rezervacija be pašnekovo"
	
	enum ReservationFlowType {
		case withCompanion
		case withoutCompanion
	}
	
	init(type: ReservationFlowType) {
		self.reservationType = type
	}
}

extension ReservationDetailsViewModel {
	public var reservationWithCompanionTitle: String {
		return type(of: self).reservationWithCompanionTitle
	}
	
	public var reservationWithoutCompanionTitle: String {
		return type(of: self).reservationWithoutCompanionTitle
	}
}
