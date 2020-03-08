//
//  InputValidation.swift
//  Caffeine
//
//  Created by Daniel Dluzhnevsky on 2020-03-08.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation
import UIKit

class InputValidation {
    public func checkForEmptyTextField(_ input: UITextField) -> Bool {
        if input.text!.trimmingCharacters(in: .whitespaces).isEmpty {
            return false
        }
        return true
    }
    public func checkForValidEmailRegularExpression(_ input: UITextField) -> Bool {
        return input.text!.isValidEmail
    }
    public func checkForValidStringRegularExpression(_ input: UITextField, _ re: String) -> Bool {
        if input.text!.range(of: re, options: .regularExpression) != nil {
            return false
        }
        return true
    }

    public func checkForValidStringLenght(_ input: UITextField, _ lenght: Int) -> Bool {
        if input.text!.count < lenght {
            return false
        }
        return true
    }

    public func shakeIfInvalid(_ textField: UITextField) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: textField.center.x - 10, y: textField.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: textField.center.x + 10, y: textField.center.y))
        textField.layer.add(animation, forKey: "position")
    }

}

extension String {
    var isValidEmail: Bool {
        return NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
}

