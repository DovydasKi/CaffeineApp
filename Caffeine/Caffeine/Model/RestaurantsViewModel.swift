//
//  RestaurantsViewModel.swift
//  Caffeine
//
//  Created by Dovydas Kiriliauskas on 2020-03-15.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class RestaurantsViewModel {
	public let coordinatesArray: [[Double]] = [
		[54.723452, 25.337927],
		[54.712976, 25.314877],
		[54.714750, 25.298599],
		[54.686098, 25.285147],
		[54.696427, 25.276900]
	]
	public let image: UIImage = #imageLiteral(resourceName: "sauletekis")
	public let address: String = "Saulėtekio al. 15"
	public let workingHours: String = "I-V 7-22\nVI- VII 9-21"
}
