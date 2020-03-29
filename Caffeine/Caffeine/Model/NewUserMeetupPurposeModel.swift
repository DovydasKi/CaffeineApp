//
//  NewUserMeetupPurposeModel.swift
//  Caffeine
//
//  Created by Daniel Dluzhnevsky on 2020-03-28.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation
import  UIKit

class NewUserMeetupPurposeModel {
    public func checkIfAlreadyExists(topicArr: [TopicModal], text: String) -> Bool {
        if topicArr.contains( where: { $0.meetupPurpose == text } ) {
            return true
        }
        return false
    }
    
    public func shakeIfInvalid(view: UIView) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: view.center.x - 10, y: view.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: view.center.x + 10, y: view.center.y))
        view.layer.add(animation, forKey: "position")
    }
}
