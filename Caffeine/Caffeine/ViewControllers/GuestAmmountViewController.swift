//
//  GuestAmmountViewController.swift
//  Caffeine
//
//  Created by Dovydas Kiriliauskas on 2020-03-28.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation
import UIKit

class GuestAmmountViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
	private let viewModel: ReservationDetailsViewModel
	private lazy var iconImage: UIImageView = self.initIconImageView()
	private lazy var titleLabel: UILabel = self.initTextLabel()
	private lazy var pickerView: UIPickerView = self.initPickerView()
	private lazy var guestsAmmountTextField: UITextField = self.initGuestsAmmountTextField()
	private lazy var saveButton: UIButton = self.initSaveButton()
	private lazy var arrowBackIcon: UIImageView = self.initArrowBackView()
	
	public init(viewModel: ReservationDetailsViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.view.addSubview(self.arrowBackIcon)
		self.activateArrowBackConstraints()
		
		self.view.addSubview(self.iconImage)
		self.activateIconConstraints()
		
		self.view.addSubview(self.titleLabel)
		self.activateTitleLabelConstraints()
		
		self.view.addSubview(self.guestsAmmountTextField)
		self.activatePickerViewConstraints()
		
		self.view.addSubview(self.saveButton)
		self.activateSaveButtonConstraints()
	}
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return self.viewModel.guestsAmmount.count
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		let row = self.viewModel.guestsAmmount[row]
		return String(row)
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		let selectedGuestsAmmount = self.viewModel.guestsAmmount[row] // selected item
		self.guestsAmmountTextField.text = String(selectedGuestsAmmount)
	}
	
	@objc func backToPreviousScreen() {
		self.navigationController?.popViewController(animated: true)
	}
	
	@objc func action() {
		view.endEditing(true)
	}
}

extension GuestAmmountViewController {
	private func initArrowBackView() -> UIImageView {
		let imageView = UIImageView()
		imageView.image = #imageLiteral(resourceName: "arrowBack").withRenderingMode(.alwaysTemplate)
		imageView.tintColor = UIColor(named: "orangeMain")
		imageView.backgroundColor = .clear
		imageView.contentMode = .scaleAspectFit
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.isUserInteractionEnabled = true
		imageView.gestureRecognizers = [UITapGestureRecognizer(target: self, action: #selector(backToPreviousScreen))]
		return imageView
	}
	
	private func initIconImageView() -> UIImageView {
		let imageView = UIImageView()
		imageView.image = #imageLiteral(resourceName: "bolt").withRenderingMode(.alwaysTemplate)
		imageView.tintColor = UIColor(named: "orangeMain")
		imageView.backgroundColor = .clear
		imageView.contentMode = .scaleAspectFit
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}
	
	private func initTextLabel() -> UILabel {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		
		let text: String
		if self.viewModel.reservationType == .withCompanion {
			text = self.viewModel.reservationWithCompanionTitle
		} else if self.viewModel.reservationType == .withoutCompanion {
			text = self.viewModel.reservationWithoutCompanionTitle
		} else {
			text = "Pašnekovo paieška"
		}
		
		label.text = text
		label.textColor = UIColor(named: "orangeMain")
		label.font = UIFont(name: "Rubik-Black", size: 34.0)
		label.numberOfLines = 2
		label.textAlignment = .center
		return label
	}
	
	private func initPickerView() -> UIPickerView {
		let pickerView = UIPickerView()
		pickerView.translatesAutoresizingMaskIntoConstraints = false
		pickerView.delegate = self
		return pickerView
	}
	
	private func initGuestsAmmountTextField() -> UITextField {
		let textField = UITextField()
		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.inputView = self.pickerView
		textField.textAlignment = .center
		textField.attributedPlaceholder = NSAttributedString(string: "Svečių kiekis", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "placeholderOrange") ?? .white])
		textField.font = UIFont(name: "Rubik-Medium", size: 24.0)
		textField.textColor = UIColor(named: "textOrange")
		
		let bottomBorder = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
		bottomBorder.backgroundColor = UIColor(named: "placeholderOrange")
		bottomBorder.translatesAutoresizingMaskIntoConstraints = false
		textField.addSubview(bottomBorder)
		bottomBorder.bottomAnchor.constraint(equalTo: textField.bottomAnchor, constant: 3).isActive = true
		bottomBorder.leftAnchor.constraint(equalTo: textField.leftAnchor).isActive = true
		bottomBorder.rightAnchor.constraint(equalTo: textField.rightAnchor).isActive = true
		bottomBorder.heightAnchor.constraint(equalToConstant: 2).isActive = true
		
		let toolBar = UIToolbar()
		toolBar.sizeToFit()
		let button = UIBarButtonItem(title: "Pasirinkti", style: .plain, target: self, action: #selector(self.action))
		toolBar.setItems([button], animated: true)
		toolBar.isUserInteractionEnabled = true
		textField.inputAccessoryView = toolBar
		return textField
	}
	
	private func initSaveButton() -> UIButton {
		let button: UIButton = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.layer.cornerRadius = 34.5
		button.layer.shadowColor = UIColor.black.cgColor
		button.layer.shadowOffset = CGSize(width: 0, height: 2)
		button.layer.shadowRadius = 4
		button.layer.shadowOpacity = 0.5
		button.backgroundColor = UIColor(named: "orangeMain")
		button.setTitle("Išsaugoti", for: .normal)
		button.setTitleColor(.white, for: .normal)
		button.titleLabel?.font = UIFont(name: "Rubik-Bold", size: UIView.margin(of: [24, 28, 32]))
		return button
	}
}

extension GuestAmmountViewController {
	private func activateIconConstraints() {
		NSLayoutConstraint.activate([
			self.iconImage.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 98.0),
			self.iconImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
			self.iconImage.heightAnchor.constraint(equalToConstant: 105.0),
			self.iconImage.widthAnchor.constraint(equalToConstant: 65.0)
		])
	}
	
	private func activateTitleLabelConstraints() {
		NSLayoutConstraint.activate([
			self.titleLabel.topAnchor.constraint(equalTo: self.iconImage.bottomAnchor, constant: 10.0),
			self.titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 65.0),
			self.titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -65.0),
			self.titleLabel.heightAnchor.constraint(equalToConstant: 82.0)
		])
	}
	
	private func activatePickerViewConstraints() {
		NSLayoutConstraint.activate([
			self.guestsAmmountTextField.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 100.0),
			self.guestsAmmountTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 32.0),
			self.guestsAmmountTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -32.0),
			self.guestsAmmountTextField.heightAnchor.constraint(equalToConstant: 32)
		])
	}
	
	private func activateSaveButtonConstraints() {
		NSLayoutConstraint.activate([
			self.saveButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 79.5),
			self.saveButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -79.5),
			self.saveButton.heightAnchor.constraint(equalToConstant: 69),
			self.saveButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -100.0)
		])
	}
	
	private func activateArrowBackConstraints() {
		NSLayoutConstraint.activate([
			self.arrowBackIcon.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16),
			self.arrowBackIcon.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32.0),
			self.arrowBackIcon.heightAnchor.constraint(equalToConstant: 32)
		])
	}
}
