//
//  Margin.swift
//  Caffeine
//
//  Created by Dovydas Kiriliauskas on 2020-03-06.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//
import Foundation
import UIKit

extension UIView {
	static func margin(of size: CGFloat) -> CGFloat {
		switch UIScreen.main.bounds.size.width {
		case 320:
			return size * 0.5
		default:
			return size
		}
	}

	static func margin(of sizes: [CGFloat], orientation: NSLayoutConstraint.Axis = .horizontal) -> CGFloat {
		let screenSize = UIScreen.main.bounds.size
		switch orientation {
		case .horizontal:
			let screenWidth = screenSize.width
			if screenWidth > 375.0, sizes.count > 2 {
				return sizes[2]
			} else if screenWidth > 320.0, sizes.count > 1 {
				return sizes[1]
			} else if !sizes.isEmpty {
				return sizes[0]
			} else {
				return 0.0
			}
		case .vertical:
			let screenHeight = screenSize.height
			if screenHeight > 812.0, sizes.count > 4 {
				return sizes[4]
			} else if screenHeight > 736.0, sizes.count > 3 {
				return sizes[3]
			} else if screenHeight > 667.0, sizes.count > 2 {
				return sizes[2]
			} else if screenHeight > 568.0, sizes.count > 1 {
				return sizes[1]
			} else if !sizes.isEmpty {
				return sizes[0]
			} else {
				return 0.0
			}
		default:
			return 0.0
		}
	}
}
