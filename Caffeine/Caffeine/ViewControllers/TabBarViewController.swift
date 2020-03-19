//
//  TabBarViewController.swift
//  Caffeine
//
//  Created by Dovydas Kiriliauskas on 2020-03-09.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation
import UIKit

class TabBarViewController: UITabBarController {
	enum TabView: Int {
		case myProfile, reservation, restaurants
	}
	
	private var contentViewControllers: [UIViewController] = []
	
	private lazy var profileViewController: UIViewController = {
		let viewController = ProfileReservationViewController()
		let title = "Profilis"
		viewController.title = title
		
		viewController.tabBarItem = UITabBarItem(
			title: title,
			image: #imageLiteral(resourceName: "profile"),
			tag: TabView.myProfile.rawValue)
		
		viewController.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile")
		let navigationController = UINavigationController(rootViewController: viewController)
		return navigationController
	}()
	
	private lazy var restaurantMapViewController: UIViewController = {
		let viewController = RestaurantsViewController()
		let title = "Kavinės"
		viewController.title = title
		
		viewController.tabBarItem = UITabBarItem(
			title: title,
			image: #imageLiteral(resourceName: "restaurant"),
			tag: TabView.restaurants.rawValue)
		
		viewController.tabBarItem.selectedImage = #imageLiteral(resourceName: "restaurant")
		let navigationController = UINavigationController(rootViewController: viewController)
		return navigationController
	}()
	
	private lazy var reservationViewController: UIViewController = {
		let viewController = LoginViewController()
		let title = "Rezervacija"
		viewController.title = title
		
		viewController.tabBarItem = UITabBarItem(
			title: title,
			image: #imageLiteral(resourceName: "reservation"),
			tag: TabView.reservation.rawValue)
		
		viewController.tabBarItem.selectedImage = #imageLiteral(resourceName: "reservation")
		let navigationController = UINavigationController(rootViewController: viewController)
		return navigationController
	}()
	
	override public func viewDidLoad() {
		super.viewDidLoad()
		
		self.view.backgroundColor = .white
		self.contentViewControllers = [self.profileViewController, self.restaurantMapViewController, self.reservationViewController]
		self.viewControllers = self.contentViewControllers
	}
}
