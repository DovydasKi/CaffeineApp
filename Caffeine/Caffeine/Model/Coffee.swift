//
//  Coffee.swift
//  Caffeine
//
//  Created by Daniel Dluzhnevsky on 2020-03-30.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation
import UIKit

class Coffee {
    var imageView: UIImageView?
    var label: UILabel?

    init(imageView: UIImageView, label: UILabel) {
        self.imageView = imageView
        self.label = label
    }
}
