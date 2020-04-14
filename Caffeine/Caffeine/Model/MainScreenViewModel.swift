//
//  MainScreenViewModel.swift
//  Caffeine
//
//  Created by Daniel Dluzhnevsky on 2020-04-14.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation
import UIKit

class MainScreenViewModel {
    private static let caffeineLabelTitle = "Caffeine"
    private static let loginButtonTitle = "Prisijungti"
    private static let getStartedButtonTitle = "Registruotis"
}

extension MainScreenViewModel {
    public var caffeineLabelTitle: String {
        type(of: self).caffeineLabelTitle
    }
    
    public var loginButtonTitle: String {
        type(of: self).loginButtonTitle
    }
    
    public var getStartedButtonTitle: String {
        type(of: self).getStartedButtonTitle
    }
}
