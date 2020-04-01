//
//  CompanionFoundViewController.swift
//  Caffeine
//
//  Created by Dovydas Kiriliauskas on 2020-04-01.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation
import NVActivityIndicatorView
import UIKit

class CompanionFoundViewController: UIViewController {
	private lazy var activityIndicator: NVActivityIndicatorView = self.initActivityIndicator()
	private lazy var titleLabel: UILabel = self.initTitleLabel()
	private lazy var iconImage: UIImageView = self.initIconImage()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = UIColor(named: "orangeMain")
		self.view.addSubview(self.iconImage)
		self.activateIconConstraints()
		
		self.view.addSubview(self.titleLabel)
		self.activateTitleLabelConstraints()
		
		self.view.addSubview(self.activityIndicator)
		self.activateIndicatorConstraints()
		
        self.activityIndicator.startAnimating()
	}
}

extension CompanionFoundViewController {
	private func initActivityIndicator() -> NVActivityIndicatorView {
		let animationTypeLabel = UILabel(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
		let activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: 100, y: 100, width: 200, height: 200), type: .ballScaleMultiple)
        animationTypeLabel.sizeToFit()
        animationTypeLabel.textColor = UIColor.white
        animationTypeLabel.frame.origin.x += 5
        animationTypeLabel.frame.origin.y += CGFloat(200) - animationTypeLabel.frame.size.height
        animationTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.padding = 20
		
		return activityIndicatorView
	}
	
	private func initTitleLabel() -> UILabel {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Rasti pašnekovai jūsų rezervacijai"
		label.textColor = .white
		label.font = UIFont(name: "Rubik-Black", size: 25.0)
		label.numberOfLines = 3
		label.textAlignment = .center
		return label
	}
	
	private func initIconImage() -> UIImageView {
		let imageView = UIImageView()
		imageView.image = #imageLiteral(resourceName: "bolt").withRenderingMode(.alwaysTemplate)
		imageView.tintColor = .white
		imageView.backgroundColor = .clear
		imageView.contentMode = .scaleAspectFit
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}
}

extension CompanionFoundViewController {
	private func activateIconConstraints() {
		NSLayoutConstraint.activate([
			self.iconImage.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 98.0),
			self.iconImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
			self.iconImage.heightAnchor.constraint(equalToConstant: 150.0),
			self.iconImage.widthAnchor.constraint(equalToConstant: 100.0)
		])
	}
	
	private func activateTitleLabelConstraints() {
		NSLayoutConstraint.activate([
			self.titleLabel.topAnchor.constraint(equalTo: self.iconImage.bottomAnchor, constant: 30.0),
			self.titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 65.0),
			self.titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -65.0),
			self.titleLabel.heightAnchor.constraint(equalToConstant: 82.0)
		])
	}
	
	private func activateIndicatorConstraints() {
		NSLayoutConstraint.activate([
			self.activityIndicator.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 30.0),
			self.activityIndicator.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
			self.activityIndicator.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
		])
	}
}
