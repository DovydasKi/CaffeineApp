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

    public func checkForValidPassword(_ passwordInput: UITextField, _ passwordRequirementCheckMark: UIImageView) {
        if passwordInput.text!.count >= 5 {
            passwordRequirementCheckMark.backgroundColor = UIColor.green
        }
        else {
            passwordRequirementCheckMark.backgroundColor = UIColor.white
        }
    }
}
