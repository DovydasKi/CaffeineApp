//
//  UserModalTests.swift
//  CaffeineTests
//
//  Created by Dovydas Kiriliauskas on 2020-04-13.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import XCTest
@testable import Caffeine

class UserModalTests: XCTestCase {
	public func testUserModalInitializer() {
		let image: UIImage = #imageLiteral(resourceName: "coffeePin")
		let name: String = "name"
		let meetupPurpose: String = "purpose"
		let address: String = "address"
		let date: String = "date"
		
		let userModal = UserModal(userImage: image, name: name, meetupPurpose: meetupPurpose, address: address, dateAndTime: date)
		
		XCTAssertEqual(userModal.userImage, image)
		XCTAssertEqual(userModal.name, name)
		XCTAssertEqual(userModal.meetupPurpose, meetupPurpose)
		XCTAssertEqual(userModal.address, address)
		XCTAssertEqual(userModal.dateAndTime, date)
	}
}
