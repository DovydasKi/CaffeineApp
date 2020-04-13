//
//  ReservationTypeViewController.swift
//  Caffeine
//
//  Created by Dovydas Kiriliauskas on 2020-03-24.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation
import UIKit

class ReservationTypeViewController: UIViewController {
	private lazy var reservationWithCompanion: UIView = self.initReservationWithCompanionView()
	private lazy var reservationWihoutCompanion: UIView = self.initReservationWithoutCompanionView()
	private lazy var companionSearch: UIView = self.initCompanionSearchView()
	private lazy var stackView: UIStackView = self.initStackView()
	private lazy var titleLabel: UIView = self.initTitleLabel()
	private let viewModel = ReservationDetailsViewModel(type: .withCompanion)
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.navigationController?.navigationBar.isHidden = true
		
		self.view.addSubview(self.titleLabel)
		self.activateTitleLabelConstraints()
		
		self.view.addSubview(self.stackView)
		self.activateStackViewConstraints()
		
		self.stackView.addArrangedSubview(UIView())
		self.stackView.addArrangedSubview(self.reservationWithCompanion)
		self.stackView.addArrangedSubview(self.reservationWihoutCompanion)
		self.stackView.addArrangedSubview(self.companionSearch)
		self.activateStackViewElementsConstraints()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		UIApplication.shared.setStatusBarStyle(.default, animated: animated)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		UIApplication.shared.setStatusBarStyle(.darkContent, animated: animated)
	}
	
	@objc private func openReservationDetailsWithCompanion() {
		let viewModel = ReservationDetailsViewModel(type: .withCompanion)
		let vc = ReservationDetailsViewController(viewModel: viewModel)
		self.navigationController?.pushViewController(vc, animated: true)
	}
	
	@objc private func openReservationDetailsWithoutCompanion() {
		let viewModel = ReservationDetailsViewModel(type: .withoutCompanion)
		let vc = ReservationDetailsViewController(viewModel: viewModel)
		self.navigationController?.pushViewController(vc, animated: true)
	}
}

extension ReservationTypeViewController {
	private func createCardTitle(text: String) -> UILabel {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = text
		label.textAlignment = .center
		label.backgroundColor = .clear
		label.textColor = .white
		label.font = UIFont(name: "Rubik-Bold", size: 25)
		return label
	}
	
	private func initReservationWithCompanionView() -> UIView {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		
		let viewText = self.viewModel.reservationWithCompanionTitle
		let titleView = self.createCardTitle(text: viewText)
		view.addSubview(titleView)
		view.backgroundColor = UIColor(named: "orangeMain")
		view.layer.cornerRadius = 10.0
		view.gestureRecognizers = [UITapGestureRecognizer(target: self, action: #selector(self.openReservationDetailsWithCompanion))]
		
		NSLayoutConstraint.activate([
			titleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14.0),
			titleView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14.0),
			titleView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8.0),
			titleView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8.0)
		])
		return view
	}
	
	private func initReservationWithoutCompanionView() -> UIView {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		
		let viewText = self.viewModel.reservationWithoutCompanionTitle
		let titleView = self.createCardTitle(text: viewText)
		view.addSubview(titleView)
		view.backgroundColor = UIColor(named: "orangeMain")
		view.layer.cornerRadius = 10.0
		view.gestureRecognizers = [UITapGestureRecognizer(target: self, action: #selector(self.openReservationDetailsWithoutCompanion))]
		
		NSLayoutConstraint.activate([
			titleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14.0),
			titleView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14.0),
			titleView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8.0),
			titleView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8.0)
		])
		return view
	}
	
	private func initTitleLabel() -> UILabel {
		let titleLabel = UILabel()
		titleLabel.text = self.viewModel.titleText
		titleLabel.font = UIFont(name: "Rubik-Bold", size: 40)
		titleLabel.textColor = UIColor(named: "orangeMain")
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		titleLabel.textAlignment = .left
		titleLabel.contentMode = .scaleAspectFit
		return titleLabel
	}
	
	private func initCompanionSearchView() -> UIView {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		
		let viewText = self.viewModel.companionSearchText
		let titleView = self.createCardTitle(text: viewText)
		view.addSubview(titleView)
		view.backgroundColor = UIColor(named: "orangeMain")
		view.layer.cornerRadius = 10.0
		
		NSLayoutConstraint.activate([
			titleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14.0),
			titleView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14.0),
			titleView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8.0),
			titleView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8.0)
		])
		return view
	}
	
	private func initStackView() -> UIStackView {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		stackView.contentMode = .scaleToFill
		stackView.layoutIfNeeded()
		stackView.spacing = 16.0
		return stackView
	}
}

extension ReservationTypeViewController {
	private func activateTitleLabelConstraints() {
		NSLayoutConstraint.activate(
			[
				self.titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
				self.titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0),
				self.titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
				self.titleLabel.heightAnchor.constraint(equalToConstant: 45.0)
		])
	}
	
	private func activateStackViewConstraints() {
		NSLayoutConstraint.activate([
			self.stackView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor),
			self.stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
			self.stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
		])
	}
	
	private func activateStackViewElementsConstraints() {
		NSLayoutConstraint.activate([
			self.reservationWithCompanion.topAnchor.constraint(equalTo: self.stackView.topAnchor, constant: 200),
			self.reservationWithCompanion.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor, constant: 16.0),
			self.reservationWithCompanion.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor, constant: -16.0),
			self.reservationWithCompanion.heightAnchor.constraint(equalToConstant: 70.0)
		])
		
		NSLayoutConstraint.activate([
			self.reservationWihoutCompanion.topAnchor.constraint(equalTo: self.reservationWithCompanion.bottomAnchor, constant: 32.0),
			self.reservationWihoutCompanion.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor, constant: 16.0),
			self.reservationWihoutCompanion.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor, constant: -16.0),
			self.reservationWihoutCompanion.heightAnchor.constraint(equalToConstant: 70.0)
		])
		
		NSLayoutConstraint.activate([
			self.companionSearch.topAnchor.constraint(equalTo: self.reservationWihoutCompanion.bottomAnchor, constant: 32.0),
			self.companionSearch.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor, constant: 16.0),
			self.companionSearch.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor, constant: -16.0),
			self.companionSearch.heightAnchor.constraint(equalToConstant: 70.0)
		])
	}
}
