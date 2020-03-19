//
//  ProfileViewModel.swift
//  Caffeine
//
//  Created by Daniel Dluzhnevsky on 2020-03-18.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewModel {}

extension UIStackView {
    func addBackground(color: UIColor, cornerRadius: CGFloat) {
        let subView = UIView(frame: bounds)
        let shadowProperty = Shadow()
        subView.backgroundColor = color
        subView.layer.cornerRadius = cornerRadius
        shadowProperty.setShadow(view: subView)
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
}
