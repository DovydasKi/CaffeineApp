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

    public func checkForValidEmailRegularExpression(input: UITextField) -> Bool {
        guard let isValid = input.text?.isValidEmail else {
            return false
        }
        return isValid
    }

    public func checkForValidStringRegularExpression(input: UITextField, regularExpression: String) -> Bool {
        guard let text = input.text else { return true }

        if text.range(of: regularExpression, options: .regularExpression) != nil {
            return false
        }
        else {
            return true
        }
    }

    public func checkForValidStringLenght(input: UITextField, lenght: Int) -> Bool {
        guard let text = input.text else { return true }
        
        if text.count < lenght {
            return false
        }
        return true
    }

    public func shakeIfInvalid(textField: UITextField) {
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

