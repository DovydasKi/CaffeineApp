//
//  PropertyCardViewController.swift
//  Caffeine
//
//  Created by Dovydas Kiriliauskas on 2020-03-18.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation
import UIKit

class PropertyCardViewController: UIView {
	private let propertyImage: UIImage
	private let propertyAddress: String
	private let propertyWorkingHours: String
	private lazy var menuButton: UIButton = self.initMenuButton()
	private lazy var closeImage: UIImageView = self.initCloseImage()
	private lazy var imageView: UIImageView = self.initImageView(image: self.propertyImage)
	private lazy var title: UILabel = self.initTitle(text: self.propertyAddress)
	private lazy var subtitle: UILabel = self.initSubtitle(text: self.propertyWorkingHours)
	
	public init(image: UIImage, address: String, workingHours: String) {
		self.propertyImage = image
		self.propertyAddress = address
		self.propertyWorkingHours = workingHours
		super.init(frame: CGRect.zero)
		self.configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func configure() {
		self.backgroundColor = .white
		self.layer.borderWidth = 2.0
		self.layer.cornerRadius = 6.0
		self.layer.borderColor = UIColor(named: "orangeMain")?.cgColor
		self.addSubview(self.imageView)
		self.activateImageConstraints()
		self.addSubview(self.title)
		self.activateTitleConstraints()
		self.addSubview(self.subtitle)
		self.activateSubtitleConstraints()
		self.addSubview(self.menuButton)
		self.activateMenuButtonConstraints()
		self.addSubview(self.closeImage)
		self.activateCloseButtonConstraints()
	}
	
	@objc private func close() {
		UIView.transition(with: self, duration: 0.5, options: [.curveEaseOut], animations: {
		  super.removeFromSuperview()
		}, completion: nil)
	}
    
    @objc private func open() {
        var topVC = UIApplication.shared.windows.filter({$0.isKeyWindow }).first?.rootViewController
        while((topVC!.presentedViewController) != nil) {
            topVC = topVC!.presentedViewController
        }
        let newVC = CafeDrinkMenuViewController()
        topVC?.present(newVC, animated: true, completion: nil)
    }
}

extension PropertyCardViewController {
	private func initMenuButton() -> UIButton {
		let button  = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.layer.cornerRadius = 5.0
		button.setTitle("Kavinės meniu", for: .normal)
		button.setTitleColor(.white, for: .normal)
		button.backgroundColor = UIColor(named: "orangeMain")
        button.addTarget(self, action: #selector(self.open), for: .touchUpInside)
		return button
	}
	
	private func initCloseImage() -> UIImageView {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.image = #imageLiteral(resourceName: "cancel").withRenderingMode(.alwaysTemplate)
		imageView.isUserInteractionEnabled = true
		imageView.tintColor = .white
		imageView.gestureRecognizers = [UITapGestureRecognizer(target: self, action: #selector(self.close))]
		imageView.backgroundColor = .clear
		imageView.contentMode = .scaleAspectFill
		return imageView
	}
	
	private func initTitle(text: String) -> UILabel {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.numberOfLines = 2
		label.textAlignment = .center
		label.font = UIFont(name: "Rubik-Bold", size: 20)
		label.text = text
		label.textColor = UIColor(named: "orangeMain")
		return label
	}
	
	private func initSubtitle(text: String) -> UILabel {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.numberOfLines = 2
		label.textAlignment = .center
		label.font = UIFont(name: "Rubik-Bold", size: 10)
		label.text = text
		label.textColor = UIColor(named: "orangeMain")
		return label
	}
	
	private func initImageView(image: UIImage) -> UIImageView {
		let imageView = UIImageView()
		imageView.layer.masksToBounds = true
		imageView.layer.cornerRadius = 6.0
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleToFill
		imageView.image = image
		return imageView
	}
}

extension PropertyCardViewController {
	private func activateImageConstraints() {
		NSLayoutConstraint.activate([
			self.imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			self.imageView.topAnchor.constraint(equalTo: self.topAnchor),
			self.imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
			self.imageView.trailingAnchor.constraint(equalTo: self.leadingAnchor, constant: 150.0)
		])
	}
	
	private func activateTitleConstraints() {
		NSLayoutConstraint.activate([
			self.title.topAnchor.constraint(equalTo: self.topAnchor, constant: 20.0),
			self.title.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: 8.0),
			self.title.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8.0),
			self.title.bottomAnchor.constraint(equalTo: self.topAnchor, constant: 36)
		])
	}
	
	private func activateSubtitleConstraints() {
		NSLayoutConstraint.activate([
			self.subtitle.topAnchor.constraint(equalTo: self.title.bottomAnchor, constant: 10.0),
			self.subtitle.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: 10.0),
			self.subtitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8.0),
			self.subtitle.heightAnchor.constraint(equalToConstant: 30)
		])
	}
	
	private func activateMenuButtonConstraints() {
		NSLayoutConstraint.activate([
			self.menuButton.topAnchor.constraint(equalTo: self.subtitle.bottomAnchor, constant: 20.0),
			self.menuButton.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: 10.0),
			self.menuButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8.0),
			self.menuButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8.0)
		])
	}
	
	private func activateCloseButtonConstraints() {
		NSLayoutConstraint.activate([
			self.closeImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 4.0),
			self.closeImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4.0),
			self.closeImage.trailingAnchor.constraint(equalTo: self.leadingAnchor, constant: 35.0),
			self.closeImage.bottomAnchor.constraint(equalTo: self.topAnchor, constant: 35.0)
		])
	}
}
