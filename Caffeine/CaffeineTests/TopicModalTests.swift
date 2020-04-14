//
//  TopicModalTests.swift
//  CaffeineTests
//
//  Created by Daniel Dluzhnevsky on 2020-04-14.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import XCTest
@testable import Caffeine

class TopicModalTests: XCTestCase {
    public func testTopicModalInitializer() {
        let meetupPurpose: String = "purpose"
        let isSelected: Bool = true
        
        let topicModal = TopicModal(meetupPurpose: meetupPurpose, isSelected: isSelected)
        
        XCTAssertEqual(topicModal.meetupPurpose, meetupPurpose)
        XCTAssertEqual(topicModal.isSelected, isSelected)

    }
}
