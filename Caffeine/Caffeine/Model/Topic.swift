//
//  Topic.swift
//  Caffeine
//
//  Created by Daniel Dluzhnevsky on 2020-03-30.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation

class TopicModal: Encodable, Decodable{
    var meetupPurpose: String?
    var isSelected: Bool?
    
    init(meetupPurpose: String, isSelected: Bool) {
        self.meetupPurpose = meetupPurpose
        self.isSelected = isSelected
    }
}
