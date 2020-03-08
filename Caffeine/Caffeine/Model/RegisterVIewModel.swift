//
//  RegisterVIewModel.swift
//  Caffeine
//
//  Created by Daniel Dluzhnevsky on 2020-03-07.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation
import UIKit


class RegisterViewModel {
    var inputValidation = InputValidation()
    
    public func checkForValidPassword(_ passwordInput: UITextField, _ passwordRequirementCheckMark: UIImageView) {
        if passwordInput.text!.count >= 5 {
            passwordRequirementCheckMark.backgroundColor = UIColor.green
        }
        else {
            passwordRequirementCheckMark.backgroundColor = UIColor.white
        }
    }
    public func checkForAllValidFields(_ fullNameField: UITextField, _ userNameField: UITextField, _ emailField: UITextField, _ passwordField: UITextField) -> Bool{
        //TODO: implement better validation
        var allValid = 4
        if self.inputValidation.checkForValidStringLenght(fullNameField, 5) == false || self.inputValidation.checkForValidStringRegularExpression(fullNameField, ".*[^A-Za-z0-9\\s].*") == false {
            self.inputValidation.shakeIfInvalid(fullNameField)
            allValid -= 1
        }
        if self.inputValidation.checkForValidStringLenght(userNameField, 5) == false || self.inputValidation.checkForValidStringRegularExpression(userNameField, ".*[^A-Za-z0-9].*") == false {
            self.inputValidation.shakeIfInvalid(userNameField)
            allValid -= 1
        }
        if self.inputValidation.checkForValidEmailRegularExpression(emailField) == false {
            self.inputValidation.shakeIfInvalid(emailField)
            allValid -= 1
        }
        if self.inputValidation.checkForValidStringLenght(passwordField, 5) == false {
            passwordField.text = ""
            self.inputValidation.shakeIfInvalid(passwordField)
            allValid -= 1
        }
        else if allValid == 4 {
            return true
        }
        return false
    }
}
