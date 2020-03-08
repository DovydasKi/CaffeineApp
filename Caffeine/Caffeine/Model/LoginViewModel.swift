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
    var inputValidation = InputValidation()
    
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
    
    public func checkForAllValidFields( _ emailField: UITextField, _ passwordField: UITextField) -> Bool{
        //TODO: implement better validation
        var allValid = 2
        if self.inputValidation.checkForValidEmailRegularExpression(emailField) == false {
            emailField.text = ""
            self.inputValidation.shakeIfInvalid(emailField)
            allValid -= 1
        }
        if self.inputValidation.checkForValidStringLenght(passwordField, 5) == false {
            passwordField.text = ""
            self.inputValidation.shakeIfInvalid(passwordField)
            allValid -= 1
        }
        else if allValid == 2 {
            return true
        }
        return false
    }
}
