//
//  PropertyCardViewModel.swift
//  Caffeine
//
//  Created by Daniel Dluzhnevsky on 2020-04-14.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation
import UIKit

class PropertyCardViewModel {
    private static let menuButtonTitle = "Kavinės meniu"
}

extension PropertyCardViewModel {
    public var menuButtonTitle: String {
        type(of: self).menuButtonTitle
    }
}
