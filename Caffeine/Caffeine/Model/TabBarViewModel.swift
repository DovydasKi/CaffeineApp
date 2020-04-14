//
//  TabBarViewModel.swift
//  Caffeine
//
//  Created by Daniel Dluzhnevsky on 2020-04-14.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation
import UIKit

class TabBarViewModel {
    private static let profileViewControllerTitle = "Profilis"
    private static let restaurantMapViewControllerTitle = "Kavinės"
    private static let reservationViewControllerTitle = "Rezervacija"
}

extension TabBarViewModel {
    public var profileViewControllerTitle: String {
        type(of: self).profileViewControllerTitle
    }
    
    public var restaurantMapViewControllerTitle: String {
        type(of: self).restaurantMapViewControllerTitle
    }
    
    public var reservationViewControllerTitle: String {
        type(of: self).reservationViewControllerTitle
    }
}
