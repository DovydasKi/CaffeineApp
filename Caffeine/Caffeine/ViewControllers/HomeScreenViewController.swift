//
//  HomeScreenViewController.swift
//  Caffeine
//
//  Created by Dovydas Kiriliauskas on 2020-03-09.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation
import UIKit

class HomeScreenViewController: UIViewController {
	var tabBar = TabBarViewController()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		navigationController?.navigationBar.isHidden = true
		self.view.addSubview(self.tabBar.view)
		self.tabBar.tabBar.tintColor = UIColor(named: "orangeMain")
		self.tabBar.tabBar.barTintColor = .white
	}
}
