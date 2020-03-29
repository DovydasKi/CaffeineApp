//
//  ProfileViewController.swift
//  Caffeine
//
//  Created by Daniel Dluzhnevsky on 2020-03-18.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation
import UIKit
import Hero

class ProfileInformationViewController: UIViewController {
    private lazy var profilePicture: UIImageView = self.initProfilePicture()
    private lazy var fullNameLabel: UILabel = self.initFullNameLabel()
    private lazy var menuBarView: UIView = self.initMenuBarView()

    private lazy var reservationButton: UIView = self.initReservationButton()
    private lazy var meetupTopicsButton: UIView = self.initMeetupTopicsButton()
    private lazy var informationButton: UIView = self.initInformationButton()

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

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .white

        self.view.addSubview(self.profilePicture)
        self.setProfilePictureConstraints()

        self.view.addSubview(self.fullNameLabel)
        self.setFullNameLabelConstraints()

        self.view.addSubview(self.menuBarView)
        self.setMenuBarViewConstraints()

        self.menuBarView.addSubview(self.reservationButton)
        self.setReservationButtonConstraints()

        self.menuBarView.addSubview(self.meetupTopicsButton)
        self.setMeetupTopicsButtonConstraints()

        self.menuBarView.addSubview(self.informationButton)
        self.setInformationButtonConstraints()

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
    @objc private func turnOnMeetupTopicsScreen() {
       let newVC = ProfileMeetupTopicsViewController()
       self.navigationController?.hero.isEnabled = true
       self.navigationController?.hero.navigationAnimationType = .selectBy(presenting: .slide(direction: .right), dismissing: .slide(direction: .right))
       self.navigationController?.viewControllers = [self]
       self.navigationController?.pushViewController(newVC, animated: true)
    }
    @objc private func turnOnReservationScreen() {
        let newVC = ProfileReservationViewController()
        self.navigationController?.hero.isEnabled = true
        self.navigationController?.hero.navigationAnimationType = .selectBy(presenting: .slide(direction: .right), dismissing: .slide(direction: .right))
        self.navigationController?.viewControllers = [self]
        self.navigationController?.pushViewController(newVC, animated: true)
    }
}

//MARK: UI elements extension
extension ProfileInformationViewController {
    private func initProfilePicture() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "profileImage6")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOffset = CGSize(width: 0, height: 2)
        imageView.layer.shadowRadius = 4
        imageView.layer.shadowOpacity = 0.5
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
        
        view.backgroundColor = .clear
        view.layer.cornerRadius = 12.5
        
        label.font = UIFont(name: "Rubik-Bold", size: 14)
        label.text = "Rezervacijos"
        label.textColor = .systemGray
        label.textAlignment = .center

        view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(turnOnReservationScreen))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tap)
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
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.turnOnMeetupTopicsScreen))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tap)
        return view
    }
    
    private func initInformationButton() -> UIView {
        let view = UIView()
        let label = UILabel()
        
        view.backgroundColor = .white
        view.layer.cornerRadius = 12.5
        
        label.font = UIFont(name: "Rubik-Bold", size: 14)
        label.text = "Informacija"
        label.textColor = .black
        label.textAlignment = .center
        view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        return view
    }

    private func initEmailTitle() -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Medium", size: UIView.margin(of: [16, 17, 18]))
        label.text = "El. pašto adresas:"
        label.textColor = UIColor(named: "orangeMain")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.contentMode = .scaleAspectFit
        return label
    }
    private func initEmailBody() -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Medium", size: UIView.margin(of: [16, 17, 18]))
        label.text = "vardas.pavardenis@stud.vgtu.lt"
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.contentMode = .scaleAspectFit
        return label
    }
    private func initEmailStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.addBackground(color: .white, cornerRadius: 12.5)
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
        label.textColor = UIColor(named: "orangeMain")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.contentMode = .scaleAspectFit
        return label
    }
    private func initUserSinceBody() -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Medium", size: UIView.margin(of: [16, 17, 18]))
        label.text = "2020-02-25"
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.contentMode = .scaleAspectFit
        return label
    }
    private func initUserSinceStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.addBackground(color: .white, cornerRadius: 12.5)
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
        label.textColor = UIColor(named: "orangeMain")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.contentMode = .scaleAspectFit
        return label
    }
    private func initPasswordBody() -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Medium", size: UIView.margin(of: [16, 17, 18]))
        label.text = "*************"
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.contentMode = .scaleAspectFit
        return label
    }
    private func initPasswordStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.addBackground(color: .white, cornerRadius: 12.5)
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

    private func setMenuBarViewConstraints() {
        NSLayoutConstraint.activate([
            self.menuBarView.topAnchor.constraint(equalTo: self.fullNameLabel.bottomAnchor, constant: 32),
            self.menuBarView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.menuBarView.heightAnchor.constraint(equalToConstant: 45),
            self.menuBarView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.menuBarView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)
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
    private func setInformationStackViewConstraints() {
        NSLayoutConstraint.activate([
            self.informationStackView.topAnchor.constraint(equalTo: self.menuBarView.bottomAnchor, constant: 32),
            self.informationStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            ])
    }
    private func setLogoutButtonConstraints() {
        NSLayoutConstraint.activate([
            self.logoutButton.topAnchor.constraint(equalTo: self.informationStackView.bottomAnchor, constant: 48),
            self.logoutButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.logoutButton.widthAnchor.constraint(equalToConstant: 254),
            self.logoutButton.heightAnchor.constraint(equalToConstant: 69)
            ])
    }
}
