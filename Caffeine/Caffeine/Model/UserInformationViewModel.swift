//
//  UserInformationViewModel.swift
//  Caffeine
//
//  Created by Daniel Dluzhnevsky on 2020-04-14.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation
import UIKit

class UserInformationViewModel {
    private static let emailTitleText = "El. pašto adresas:"
    private static let emailBodyText = "vardas.pavardenis@stud.vgtu.lt"
    private static let userSinceTitleText = "Akyvus nuo:"
    private static let userSinceBodyText = "2020-02-25"
    private static let passwordTitleText = "Slaptažodis:"
    private static let passwordBodyText = "*************"
    private static let logoutButtonText = "Atsijungti"
}

extension UserInformationViewModel {
    public var emailTitleText: String {
        type(of: self).emailTitleText
    }
    
    public var emailBodyText: String {
        type(of: self).emailBodyText
    }
    
    public var userSinceTitleText: String {
        type(of: self).userSinceTitleText
    }
    
    public var userSinceBodyText: String {
        type(of: self).userSinceBodyText
    }
    
    public var passwordTitleText: String {
        type(of: self).passwordTitleText
    }
    
    public var passwordBodyText: String {
        type(of: self).passwordBodyText
    }
    
    public var logoutButtonText: String {
        type(of: self).logoutButtonText
    }
}
