//
//  ProfileViewModel.swift
//  Caffeine
//
//  Created by Daniel Dluzhnevsky on 2020-03-18.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewModel {
    private static let fullNameTitle = "Vardenis Pavardenis"
    private static let firstButtonTitle = "Rezervacijos"
    private static let secondButtonTitle = "Pokalbio temos"
    private static let thirdButtonTitle = "Informacija"
}

extension ProfileViewModel {
    public var fullNameTitle: String {
        type(of: self).fullNameTitle
    }
    public var firstButtonTitle: String {
        type(of: self).firstButtonTitle
    }
    public var secondButtonTitle: String {
        type(of: self).secondButtonTitle
    }
    public var thirdButtonTitle: String {
        type(of: self).thirdButtonTitle
    }
}
