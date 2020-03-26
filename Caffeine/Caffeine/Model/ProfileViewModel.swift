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
        subView.backgroundColor = color
        subView.layer.cornerRadius = cornerRadius
        subView.layer.shadowColor = UIColor.black.cgColor
        subView.layer.shadowOffset = CGSize(width: 0, height: 2)
        subView.layer.shadowRadius = 4
        subView.layer.shadowOpacity = 0.5
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
}
