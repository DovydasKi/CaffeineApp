//
//  User.swift
//  Caffeine
//
//  Created by Daniel Dluzhnevsky on 2020-03-30.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation
import UIKit

class UserModal {
    var userImage: UIImage?
    var name: String?
    var meetupPurpose: String?
    var address: String?
    var dateAndTime: String?

    init(userImage: UIImage, name: String, meetupPurpose: String, address: String, dateAndTime: String) {
        self.userImage = userImage
        self.name = name
        self.meetupPurpose = meetupPurpose
        self.address = address
        self.dateAndTime = dateAndTime
    }
}
