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

    public func checkForValidPassword(passwordInput: UITextField, passwordRequirementCheckMark: UIImageView) {
        if inputValidation.checkForValidStringLenght(input: passwordInput, lenght: 5) {
            passwordRequirementCheckMark.backgroundColor = UIColor.green
        }
        else {
            passwordRequirementCheckMark.backgroundColor = UIColor.white
        }
    }
    public func checkForAllValidFields(fullNameField: UITextField, userNameField: UITextField, emailField: UITextField, passwordField: UITextField) -> Bool {

        var fullNameIsValid = false
        var userNameIsValid = false
        var emailIsValid = false
        var passwordIsValid = false

        if !self.inputValidation.checkForValidStringLenght(input: fullNameField, lenght: 5) || !self.inputValidation.checkForValidStringRegularExpression(input: fullNameField, re: ".*[^A-Za-z0-9\\s].*") {
            self.inputValidation.shakeIfInvalid(textField: fullNameField)
        }
        else { fullNameIsValid = true }
        if !self.inputValidation.checkForValidStringLenght(input: userNameField, lenght: 5) || !self.inputValidation.checkForValidStringRegularExpression(input: userNameField, re: ".*[^A-Za-z0-9].*") {
            self.inputValidation.shakeIfInvalid(textField: userNameField)
        }
        else { userNameIsValid = true }
        if !self.inputValidation.checkForValidEmailRegularExpression(input: emailField) {
            self.inputValidation.shakeIfInvalid(textField: emailField)
        }
        else { emailIsValid = true }
        if !self.inputValidation.checkForValidStringLenght(input: passwordField, lenght: 5) {
            passwordField.text = ""
            self.inputValidation.shakeIfInvalid(textField: passwordField)
        }
        else { passwordIsValid = true }
        if fullNameIsValid && userNameIsValid && emailIsValid && passwordIsValid {
            return true
        }
        return false
    }
}
