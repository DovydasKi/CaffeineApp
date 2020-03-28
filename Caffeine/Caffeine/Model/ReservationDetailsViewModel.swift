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
	
	enum ReservationFlowType {
		case withCompanion
		case withoutCompanion
	}
	
	init(type: ReservationFlowType) {
		self.reservationType = type
	}
}
