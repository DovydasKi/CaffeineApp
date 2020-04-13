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
	private static let signupTitleText = "Registracija"
	private static let fullNameTextFieldPlaceholderText = "Vardas Pavardė"
	private static let userNameTextFieldPlaceholderText = "Naudotojo vardas"
	private static let emailTextFieldPlaceholderText = "El.paštas"
	private static let passwordTextFieldPlaceholderText = "Slaptažodis"
	private static let passwordRequirementText = "5 simboliai slaptažodyje"
	private static let createAccountButtonTitleText = "Sukurti paskyrą"
	private static let dislaimerText = "Sukurdami paskyrą sutinkate su mūsų paslaugų tiekimo ir privatumo politika"
	private static let alertTitleText = "Klaida!"
	private static let alertMessageText = "Neteisingas El.paštas"
	
    var inputValidation = InputValidation()

    //MARK: UI changes shouldn't be done on ViewModel. In the future this method should be refactored
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

        if !self.inputValidation.checkForValidStringLenght(input: fullNameField, lenght: 5) || !self.inputValidation.checkForValidStringRegularExpression(input: fullNameField, regularExpression: ".*[^A-Za-z0-9\\s].*") {
            self.inputValidation.shakeIfInvalid(textField: fullNameField)
        }
        else { fullNameIsValid = true }
        if !self.inputValidation.checkForValidStringLenght(input: userNameField, lenght: 5) || !self.inputValidation.checkForValidStringRegularExpression(input: userNameField, regularExpression: ".*[^A-Za-z0-9].*") {
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

extension RegisterViewModel {
	public var signupTitleText: String {
		type(of: self).signupTitleText
	}
	
	public var fullNameTextFieldPlaceholderText: String {
		type(of: self).fullNameTextFieldPlaceholderText
	}
	
	public var userNameTextFieldPlaceholderText: String {
		type(of: self).userNameTextFieldPlaceholderText
	}
	
	public var emailTextFieldPlaceholderText: String {
		type(of: self).emailTextFieldPlaceholderText
	}
	
	public var passwordTextFieldPlaceholderText: String {
		type(of: self).passwordTextFieldPlaceholderText
	}
	
	public var passwordRequirementText: String {
		type(of: self).passwordRequirementText
	}
	
	public var createAccountButtonTitleText: String {
		type(of: self).createAccountButtonTitleText
	}
	
	public var dislaimerText: String {
		type(of: self).dislaimerText
	}
	
	public var alertTitleText: String {
		type(of: self).alertTitleText
	}
	
	public var alertMessageText: String {
		type(of: self).alertMessageText
	}
}
