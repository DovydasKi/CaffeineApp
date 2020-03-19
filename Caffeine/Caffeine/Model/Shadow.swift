//
//  Shadow.swift
//  Caffeine
//
//  Created by Daniel Dluzhnevsky on 2020-03-18.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation
import UIKit

class Shadow {
    public func setShadow(view: UIView) {
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 0.5
    }
}
