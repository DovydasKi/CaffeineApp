//
//  ProfileViewController.swift
//  Caffeine
//
//  Created by Daniel Dluzhnevsky on 2020-03-18.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation
import UIKit

class ProfileInformationViewController: UIViewController {
    private lazy var profilePicture: UIImageView = self.initProfilePicture()
    private lazy var fullNameLabel: UILabel = self.initFullNameLabel()
    private lazy var reservationButton: UILabel = self.initReservationButton()
    private lazy var informationButton: UILabel = self.initInformationButton()
    private lazy var menuBarStackView: UIStackView = self.initMenuBarStackView()
    private lazy var emaillTitle: UILabel = self.initEmailTitle()
    private lazy var emailBody: UILabel = self.initEmailBody()
    private lazy var emailStackView: UIStackView = self.initEmailStackView()
    private lazy var userSinceTitle: UILabel = self.initUserSinceTitle()
    private lazy var userSinceBody: UILabel = self.initUserSinceBody()
    private lazy var userSinceStackView: UIStackView = self.initUserSinceStackView()
    private lazy var passwordTitle: UILabel = self.initPasswordTitle()
    private lazy var passwordBody: UILabel = self.initPasswordBody()
    private lazy var passwordStackView: UIStackView = self.initPasswordStackView()
    private lazy var informationStackView: UIStackView = self.initInformationStackView()
    private lazy var logoutButton: UIButton = self.initLogoutButton()
    private lazy var shadowProperty = Shadow()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .white

        self.view.addSubview(self.profilePicture)
        self.setProfilePictureConstraints()

        self.view.addSubview(self.fullNameLabel)
        self.setFullNameLabelConstraints()

        self.view.addSubview(menuBarStackView)
        self.setMenuBarStackViewConstraints()

        self.view.addSubview(self.emailStackView)
        self.view.addSubview(self.userSinceStackView)
        self.view.addSubview(self.passwordStackView)

        self.view.addSubview(self.informationStackView)
        self.setInformationStackViewConstraints()

        self.view.addSubview(self.logoutButton)
        self.setLogoutButtonConstraints()
    }
}

//MARK: Button actions
extension ProfileInformationViewController {
    @objc private func turnOnReservationScreen() {
        let newVC = ProfileReservationViewController()
        self.navigationController?.setViewControllers([newVC], animated: true)
    }
}

//MARK: UI elements extension
extension ProfileInformationViewController {
    private func initProfilePicture() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "profileImage6")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.shadowProperty.setShadow(view: imageView)
        return imageView
    }
    private func initFullNameLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Bold", size: UIView.margin(of: [20, 24, 28]))
        label.text = "Vardenis Pavardenis"
        label.textColor = UIColor(named: "orangeMain")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.contentMode = .scaleAspectFit
        return label
    }
    private func initReservationButton() -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Bold", size: UIView.margin(of: [16, 18, 20]))
        label.text = "Rezervacijos"
        label.textColor = UIColor(named: "orangeMain")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.contentMode = .scaleAspectFit
        let tap = UITapGestureRecognizer(target: self, action: #selector(turnOnReservationScreen))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tap)
        return label
    }
    private func initInformationButton() -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Bold", size: UIView.margin(of: [16, 18, 20]))
        label.text = "Informacija"
        label.textColor = UIColor(named: "orangeMain")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.contentMode = .scaleAspectFit

        let bottomBorder = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        bottomBorder.backgroundColor = UIColor(named: "orangeMain")
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        label.addSubview(bottomBorder)
        bottomBorder.bottomAnchor.constraint(equalTo: label.bottomAnchor, constant: 3).isActive = true
        bottomBorder.leftAnchor.constraint(equalTo: label.leftAnchor).isActive = true
        bottomBorder.rightAnchor.constraint(equalTo: label.rightAnchor).isActive = true
        bottomBorder.heightAnchor.constraint(equalToConstant: 3).isActive = true
        return label
    }

    private func initMenuBarStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 128
        stackView.addArrangedSubview(self.reservationButton)
        stackView.addArrangedSubview(self.informationButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    private func initEmailTitle() -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Medium", size: UIView.margin(of: [16, 17, 18]))
        label.text = "El. pašto adresas:"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.contentMode = .scaleAspectFit
        return label
    }
    private func initEmailBody() -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Medium", size: UIView.margin(of: [16, 17, 18]))
        label.text = "vardas.pavardenis@stud.vgtu.lt"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.contentMode = .scaleAspectFit
        return label
    }
    private func initEmailStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.addBackground(color: UIColor(named: "orangeMain") ?? .white, cornerRadius: 12.5)
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.addArrangedSubview(self.emaillTitle)
        stackView.addArrangedSubview(self.emailBody)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.heightAnchor.constraint(equalToConstant: 72).isActive = true
        stackView.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        stackView.isLayoutMarginsRelativeArrangement = true

        return stackView
    }
    private func initUserSinceTitle() -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Medium", size: UIView.margin(of: [16, 17, 18]))
        label.text = "Akyvus nuo:"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.contentMode = .scaleAspectFit
        return label
    }
    private func initUserSinceBody() -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Medium", size: UIView.margin(of: [16, 17, 18]))
        label.text = "2020-02-25"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.contentMode = .scaleAspectFit
        return label
    }
    private func initUserSinceStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.addBackground(color: UIColor(named: "orangeMain") ?? .white, cornerRadius: 12.5)
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.addArrangedSubview(self.userSinceTitle)
        stackView.addArrangedSubview(self.userSinceBody)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.heightAnchor.constraint(equalToConstant: 72).isActive = true
        stackView.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }
    private func initPasswordTitle() -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Medium", size: UIView.margin(of: [16, 17, 18]))
        label.text = "Slpatažodis:"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.contentMode = .scaleAspectFit
        return label
    }
    private func initPasswordBody() -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Medium", size: UIView.margin(of: [16, 17, 18]))
        label.text = "*************"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.contentMode = .scaleAspectFit
        return label
    }
    private func initPasswordStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.addBackground(color: UIColor(named: "orangeMain") ?? .white, cornerRadius: 12.5)
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.addArrangedSubview(self.passwordTitle)
        stackView.addArrangedSubview(self.passwordBody)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.heightAnchor.constraint(equalToConstant: 72).isActive = true
        stackView.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }
    private func initInformationStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.fill
        stackView.spacing = 32
        stackView.addArrangedSubview(self.emailStackView)
        stackView.addArrangedSubview(self.userSinceStackView)
        stackView.addArrangedSubview(self.passwordStackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    private func initLogoutButton() -> UIButton {
        let button: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 304, height: 42))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 34.5
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.5
        button.backgroundColor = UIColor(named: "orangeMain")
        button.setTitle("Atsijungti", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Rubik-Bold", size: UIView.margin(of: [20, 22, 24]))
        return button
    }
}

//MARK: Constraints extension
extension ProfileInformationViewController {
    private func setProfilePictureConstraints() {
        NSLayoutConstraint.activate([
            self.profilePicture.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16),
            self.profilePicture.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.profilePicture.heightAnchor.constraint(equalToConstant: 144),
            self.profilePicture.widthAnchor.constraint(equalToConstant: 144)
        ])
    }

    private func setFullNameLabelConstraints() {
        NSLayoutConstraint.activate([
            self.fullNameLabel.topAnchor.constraint(equalTo: self.profilePicture.bottomAnchor, constant: 16),
            self.fullNameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }

    private func setMenuBarStackViewConstraints() {
        NSLayoutConstraint.activate([
            self.menuBarStackView.topAnchor.constraint(equalTo: self.fullNameLabel.bottomAnchor, constant: 32),
            self.menuBarStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }

    private func setInformationStackViewConstraints() {
        NSLayoutConstraint.activate([
            self.informationStackView.topAnchor.constraint(equalTo: self.menuBarStackView.bottomAnchor, constant: 64),
            self.informationStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
    private func setLogoutButtonConstraints() {
        NSLayoutConstraint.activate([
            self.logoutButton.topAnchor.constraint(equalTo: self.informationStackView.bottomAnchor, constant: 64),
            self.logoutButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.logoutButton.widthAnchor.constraint(equalToConstant: 254),
            self.logoutButton.heightAnchor.constraint(equalToConstant: 69)
        ])
    }
}
