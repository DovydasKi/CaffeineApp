//
//  DetailedCoffeeViewModelTests.swift
//  CaffeineTests
//
//  Created by Daniel Dluzhnevsky on 2020-04-14.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import XCTest
@testable import Caffeine

class DetailedCoffeeViewModelTests: XCTestCase {
    public func testDescriptionTextViewText() {
        let viewModel = DetailedCoffeeViewModel()
        let expectedResult = "Etiopijos ūkininkų užauginama šalies kava buvo griežtai registruojama ir eksportuojama keletu pavadinimu – Yirgacheffe, Sidamo, Harar regionų vardais. \nTokie išskirtiniai derliai buvo atsekami pagal tikslius vietovardžius ir ūkininkų pavardes"

        XCTAssertEqual(viewModel.descriptionTextViewText, expectedResult)
    }
    
    public func testCancelButtonText() {
           let viewModel = DetailedCoffeeViewModel()
           let expectedResult = "Atšaukti"

           XCTAssertEqual(viewModel.cancelButtonText, expectedResult)
       }
}

