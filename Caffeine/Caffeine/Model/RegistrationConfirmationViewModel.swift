//
//  RegistrationConfirmationViewModel.swift
//  Caffeine
//
//  Created by Daniel Dluzhnevsky on 2020-04-14.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation
import UIKit

class RegistrationConfirmationViewModel {
    private static let caffeineLabelTitle = "Caffeine"
    private static let confirmationLabelTitle = "Patvirtinkite el.pašto adresą"
}

extension RegistrationConfirmationViewModel {
    public var caffeineLabelTitle: String {
        type(of: self).caffeineLabelTitle
    }
    
    public var confirmationLabelTitle: String {
        type(of: self).confirmationLabelTitle
    }
}
