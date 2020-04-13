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
	private static let loginTitle = "Prisijungimas"
	private static let loginButtonTitle = "Prisijungti"
	private static let emailTitle = "El.paštas"
	private static let passwordTitle = "Slaptažodis"
	private static let dontHaveAccountTitle = "Neturite paskyros?\nUžsiregistruokite!"
	private static let forgotPasswordTitle = "Pamiršote slaptažodį?"
	private static let incorrectPasswordText = "Neteisingas El.paštas arba slaptažodis"
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

extension LoginViewModel {
	public var loginTitle: String {
		type(of: self).loginTitle
	}
	
	public var emailTitle: String {
		type(of: self).emailTitle
	}
	
	public var passwordTitle: String {
		type(of: self).passwordTitle
	}
	
	public var dontHaveAccountTitle: String {
		type(of: self).dontHaveAccountTitle
	}
	
	public var forgotPasswordTitle: String {
		type(of: self).forgotPasswordTitle
	}
	
	public var loginButtonTitle: String {
		type(of: self).loginButtonTitle
	}
	
	public var incorrectPasswordText: String {
		type(of: self).incorrectPasswordText
	}
}
