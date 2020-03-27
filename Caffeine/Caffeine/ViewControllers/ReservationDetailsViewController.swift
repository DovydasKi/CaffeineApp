//
//  ReservationDetailsViewController.swift
//  Caffeine
//
//  Created by Dovydas Kiriliauskas on 2020-03-25.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation
import UIKit

class ReservationDetailsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
	private lazy var titleLabel: UILabel = self.initTextLabel()
	private lazy var iconView: UIImageView = self.initImageView()
	private lazy var arrowBackImage: UIImageView = self.initArrowBackView()
	private lazy var saveButton: UIButton = self.initSaveButton()
	private lazy var cafePickerView: UIPickerView = self.initPickerView()
	private lazy var cafeTextField: UITextField = self.initCafeTextField()
	private lazy var datePicker: UIDatePicker = self.initDatePicker()
	private lazy var reservationDateTextField: UITextField = self.initDateTextField()
	private lazy var conversationTheme: UITextField = self.initConversationThemeField()
	let viewModel: ReservationDetailsViewModel
	
	public init(viewModel: ReservationDetailsViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.view.addSubview(self.arrowBackImage)
		self.activateArrowBackConstraints()
		
		self.view.addSubview(self.iconView)
		self.activateIconConstraints()
		
		self.view.addSubview(self.titleLabel)
		self.activateTitleLabelConstraints()
		
		self.view.addSubview(self.cafeTextField)
		self.activatePickerViewConstraints()
		
		self.view.addSubview(self.reservationDateTextField)
		self.activateTimePickerViewConstraints()
		
		if viewModel.reservationType == .withCompanion {
			self.view.addSubview(self.conversationTheme)
			self.activateConversationThemeTextFieldConstraints()
			
		}
		self.view.addSubview(self.saveButton)
		self.activateSaveButtonConstraints()
	}
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return self.viewModel.cafeAddresses.count
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		let row = self.viewModel.cafeAddresses[row]
		return row
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		let selectedCafe = self.viewModel.cafeAddresses[row] // selected item
		self.cafeTextField.text = selectedCafe
	}
	
	@objc func action() {
		view.endEditing(true)
	}
	
	@objc func datePickerValueChanged(_ sender: UIDatePicker) {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
		let selectedDate: String = dateFormatter.string(from: sender.date)
		self.reservationDateTextField.text = selectedDate
	}
	
	@objc func backToReservationTypeScreen() {
		self.navigationController?.popViewController(animated: true)
	}
}

extension ReservationDetailsViewController {
	private func initArrowBackView() -> UIImageView {
		let imageView = UIImageView()
		imageView.image = #imageLiteral(resourceName: "arrowBack").withRenderingMode(.alwaysTemplate)
		imageView.tintColor = UIColor(named: "orangeMain")
		imageView.backgroundColor = .clear
		imageView.contentMode = .scaleAspectFit
		imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
		imageView.gestureRecognizers = [UITapGestureRecognizer(target: self, action: #selector(backToReservationTypeScreen))]
		return imageView
	}
	
	private func initImageView() -> UIImageView {
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
			text = "Rezervacija su pašnekovu"
		} else if self.viewModel.reservationType == .withoutCompanion {
			text = "Rezervacija be pašnekovo"
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
	
	private func initDatePicker() -> UIDatePicker {
		let pickerView = UIDatePicker()
		pickerView.translatesAutoresizingMaskIntoConstraints = false
		pickerView.datePickerMode = UIDatePicker.Mode.dateAndTime
		pickerView.addTarget(self, action: #selector(self.datePickerValueChanged(_:)), for: .valueChanged)
		
		return pickerView
	}
	
	private func initCafeTextField() -> UITextField {
		let textField = UITextField()
		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.inputView = self.cafePickerView
		textField.textAlignment = .center
		textField.attributedPlaceholder = NSAttributedString(string: "Kavinė", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "placeholderOrange") ?? .white])
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
	
	private func initDateTextField() -> UITextField {
		let textField = UITextField()
		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.inputView = self.datePicker
		textField.textAlignment = .center
		textField.attributedPlaceholder = NSAttributedString(string: "Laikas", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "placeholderOrange") ?? .white])
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
	
	private func initConversationThemeField() -> UITextField {
		let textField = UITextField()
		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.textAlignment = .center
		textField.attributedPlaceholder = NSAttributedString(string: "Pokalbio tema", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "placeholderOrange") ?? .white])
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

extension ReservationDetailsViewController {
	private func activatePickerViewConstraints() {
		NSLayoutConstraint.activate([
			self.cafeTextField.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 45.0),
			self.cafeTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 32.0),
			self.cafeTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -32.0),
			self.cafeTextField.heightAnchor.constraint(equalToConstant: 32)
		])
	}
	
	private func activateTimePickerViewConstraints() {
		NSLayoutConstraint.activate([
			self.reservationDateTextField.topAnchor.constraint(equalTo: self.cafeTextField.bottomAnchor, constant: 30.0),
			self.reservationDateTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 32.0),
			self.reservationDateTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -32.0),
			self.reservationDateTextField.heightAnchor.constraint(equalToConstant: 32)
		])
	}
	
	private func activateIconConstraints() {
		NSLayoutConstraint.activate([
			self.iconView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 98.0),
			self.iconView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
			self.iconView.heightAnchor.constraint(equalToConstant: 105.0),
			self.iconView.widthAnchor.constraint(equalToConstant: 65.0)
		])
	}
	
	private func activateTitleLabelConstraints() {
		NSLayoutConstraint.activate([
			self.titleLabel.topAnchor.constraint(equalTo: self.iconView.bottomAnchor, constant: 10.0),
			self.titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 65.0),
			self.titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -65.0),
			self.titleLabel.heightAnchor.constraint(equalToConstant: 82.0)
		])
	}
	
	private func activateConversationThemeTextFieldConstraints() {
		NSLayoutConstraint.activate([
			self.conversationTheme.topAnchor.constraint(equalTo: self.reservationDateTextField.bottomAnchor, constant: 30.0),
			self.conversationTheme.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 32.0),
			self.conversationTheme.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -32.0),
			self.conversationTheme.heightAnchor.constraint(equalToConstant: 32)
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
			self.arrowBackImage.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16),
            self.arrowBackImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32.0),
            self.arrowBackImage.heightAnchor.constraint(equalToConstant: 32)
		])
	}
}
