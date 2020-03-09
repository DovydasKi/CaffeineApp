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

    public func checkForAllValidFields(emailField: UITextField, passwordField: UITextField) -> Bool {
        var emailIsValid = false
        var passwordIsValid = false
        if !self.inputValidation.checkForValidEmailRegularExpression(input: emailField) {
            emailField.text = ""
            self.inputValidation.shakeIfInvalid(textField: emailField)
        } else { emailIsValid = true }
        if !self.inputValidation.checkForValidStringLenght(input: passwordField, lenght: 5) {
            passwordField.text = ""
            self.inputValidation.shakeIfInvalid(textField: passwordField)
        } else { passwordIsValid = true }
        if emailIsValid && passwordIsValid {
            return true
        }
        return false
    }
}
