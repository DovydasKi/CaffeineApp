//
//  SplashScreenViewModel.swift
//  Caffeine
//
//  Created by Daniel Dluzhnevsky on 2020-04-14.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation
import UIKit

class SplashScreenViewModel {
    private static let caffeineLabelTitle = "Caffeine"
}

extension SplashScreenViewModel {
    public var caffeineLabelTitle: String {
        type(of: self).caffeineLabelTitle
    }
}
