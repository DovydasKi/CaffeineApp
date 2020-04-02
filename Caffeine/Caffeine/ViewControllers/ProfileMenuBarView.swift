//
//  ProfileMenuBarView.swift
//  Caffeine
//
//  Created by Daniel Dluzhnevsky on 2020-04-01.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation
import UIKit

class ProfileMenuBar: UIView {
    lazy var containerView: UIView = self.initContainerView()
    lazy var menuBarView: UIView = self.initMenuBarView()
    lazy var reservationButton: UIView = self.initReservationButton()
    lazy var meetupTopicsButton: UIView = self.initMeetupTopicsButton()
    lazy var informationButton: UIView = self.initInformationButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }

    private func setupView() {
        backgroundColor = .clear
        self.configureContainerView()
        self.configureMenuBarView()
    }
}

//MARK: UI configuratrion
extension ProfileMenuBar {
    private func configureContainerView() {
        self.addSubview(self.containerView)
        self.setContainerViewConstraints()
    }

    private func configureReservationButton() {
        self.menuBarView.addSubview(self.reservationButton)
        self.setReservationButtonConstraints()
    }

    private func configureMeetupTopicsButton() {
        self.menuBarView.addSubview(self.meetupTopicsButton)
        self.setMeetupTopicsButtonConstraints()
    }

    private func configureInformationButton() {
        self.menuBarView.addSubview(self.informationButton)
        self.setInformationButtonConstraints()
    }

    private func configureMenuBarView() {
        self.containerView.addSubview(self.menuBarView)
        self.setMenuBarViewConstraints()
        self.configureReservationButton()
        self.configureMeetupTopicsButton()
        self.configureInformationButton()
    }
}

//MARK: UI elements extension
extension ProfileMenuBar {
    private func initContainerView() -> UIView {
        let view = UIView()
        view.backgroundColor = .orange
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }

    private func initMenuBarView() -> UIView {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9176470588, green: 0.9176470588, blue: 0.9254901961, alpha: 1)
        view.layer.cornerRadius = 12.5

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }

    private func initReservationButton() -> UIView {
        let view = UIView()
        let label = UILabel()

        view.backgroundColor = .white
        view.layer.cornerRadius = 12.5

        label.font = UIFont(name: "Rubik-Bold", size: 14)
        label.text = "Rezervacijos"
        label.textColor = .black
        label.textAlignment = .center

        view.addSubview(label)

        label.translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        return view
    }

    private func initMeetupTopicsButton() -> UIView {
        let view = UIView()
        let label = UILabel()

        view.backgroundColor = .clear
        view.layer.cornerRadius = 12.5

        label.font = UIFont(name: "Rubik-Bold", size: 14)
        label.text = "Pokalbio temos"
        label.textColor = .systemGray
        label.textAlignment = .center
        view.addSubview(label)

        label.translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(turnOnMeetupTopicsScreen))
//        view.isUserInteractionEnabled = true
//        view.addGestureRecognizer(tap)
        return view
    }

    private func initInformationButton() -> UIView {
        let view = UIView()
        let label = UILabel()

        view.backgroundColor = .clear
        view.layer.cornerRadius = 12.5

        label.font = UIFont(name: "Rubik-Bold", size: 14)
        label.text = "Informacija"
        label.textColor = .systemGray
        label.textAlignment = .center
        view.addSubview(label)

        label.translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

//        let tap = UITapGestureRecognizer(target: self, action: #selector(self.turnOnInformationScreen))
//        view.isUserInteractionEnabled = true
//        view.addGestureRecognizer(tap)
        return view
    }


    private func initMenuBarStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 16
        stackView.addArrangedSubview(self.reservationButton)
        stackView.addArrangedSubview(self.informationButton)
        stackView.addArrangedSubview(self.meetupTopicsButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
}

//MARK: UI elements extension
extension ProfileMenuBar {
    private func setContainerViewConstraints() {
        NSLayoutConstraint.activate([
            self.containerView.topAnchor.constraint(equalTo: self.topAnchor),
            self.containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            ])
    }
    private func setMenuBarViewConstraints() {
        NSLayoutConstraint.activate([
            self.menuBarView.topAnchor.constraint(equalTo: self.topAnchor),
            self.menuBarView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.menuBarView.heightAnchor.constraint(equalToConstant: 45),
            self.menuBarView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor),
            self.menuBarView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor)
//            self.menuBarView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 16),
//            self.menuBarView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -16)
            ])
    }

    private func setReservationButtonConstraints() {
        NSLayoutConstraint.activate([
            self.reservationButton.topAnchor.constraint(equalTo: self.menuBarView.topAnchor, constant: 4),
            self.reservationButton.widthAnchor.constraint(equalToConstant: 123),
            self.reservationButton.bottomAnchor.constraint(equalTo: self.menuBarView.bottomAnchor, constant: -4),
            self.reservationButton.leadingAnchor.constraint(equalTo: self.menuBarView.leadingAnchor, constant: 4)
            ])
    }

    private func setMeetupTopicsButtonConstraints() {
        NSLayoutConstraint.activate([
            self.meetupTopicsButton.centerXAnchor.constraint(equalTo: self.menuBarView.centerXAnchor),
            self.meetupTopicsButton.widthAnchor.constraint(equalToConstant: 123),
            self.meetupTopicsButton.topAnchor.constraint(equalTo: self.menuBarView.topAnchor, constant: 4),
            self.meetupTopicsButton.bottomAnchor.constraint(equalTo: self.menuBarView.bottomAnchor, constant: -4)
            ])
    }

    private func setInformationButtonConstraints() {
        NSLayoutConstraint.activate([
            self.informationButton.topAnchor.constraint(equalTo: self.menuBarView.topAnchor, constant: 4),
            self.informationButton.widthAnchor.constraint(equalToConstant: 123),
            self.informationButton.bottomAnchor.constraint(equalTo: self.menuBarView.bottomAnchor, constant: -4),
            self.informationButton.trailingAnchor.constraint(equalTo: self.menuBarView.trailingAnchor, constant: -4)
            ])
    }
}


