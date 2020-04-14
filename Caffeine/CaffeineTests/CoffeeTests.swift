//
//  CoffeeTests.swift
//  CaffeineTests
//
//  Created by Daniel Dluzhnevsky on 2020-04-14.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import XCTest
@testable import Caffeine

class CoffeeTests: XCTestCase {
    public func testCoffeeInitializer() {
        let imageView: UIImageView = UIImageView()
        let label: UILabel = UILabel()
        
        let coffee = Coffee(imageView: imageView, label: label)
        
        XCTAssertEqual(coffee.imageView, imageView)
        XCTAssertEqual(coffee.label, label)
    
    }
}
