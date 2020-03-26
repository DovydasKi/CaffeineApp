//
//  StringExtension.swift
//  Caffeine
//
//  Created by Daniel Dluzhnevsky on 2020-03-26.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation

extension StringProtocol {
    var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
    var firstLowercased: String { prefix(1).lowercased() + dropFirst() }
}

extension LosslessStringConvertible {
    var string: String { .init(self) }
}

extension String {
    var isValidEmail: Bool {
        return NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
}
