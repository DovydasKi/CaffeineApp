//
//  MainScreenViewController.swift
//  Caffeine
//
//  Created by Dovydas Kiriliauskas on 2020-03-04.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation
import UIKit

class MainScreenViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = UIColor(named: "orangeMain")
		
		let title = UILabel()
		title.text = "heeeey"
		title.textColor = .white
		title.translatesAutoresizingMaskIntoConstraints = false
		
		self.view.addSubview(title)
		title.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
		title.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
	}
}
