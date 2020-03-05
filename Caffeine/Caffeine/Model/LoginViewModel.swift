//
//  LoginViewModel.swift
//  Caffeine
//
//  Created by Daniel Dluzhnevsky on 2020-03-05.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation
import UIKit

class LoginViewModel {
    public func checkForInvalidInut(_ emailInput: UITextField) -> Bool {
        if emailInput.text!.trimmingCharacters(in: .whitespaces).isEmpty {
            return true
        }
        else if emailInput.text!.count <= 3 {
            return true
        }
        else if emailInput.text!.range(of: ".*[^A-Za-z0-9].*", options: .regularExpression) != nil {
            return true
        }
        return false
    }
}
