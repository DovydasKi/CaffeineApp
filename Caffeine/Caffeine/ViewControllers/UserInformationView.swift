//
//  UserInformationView.swift
//  Caffeine
//
//  Created by Daniel Dluzhnevsky on 2020-04-01.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation
import UIKit

class UserInformationView: UIView {
    lazy var containerView: UIView = self.initContainerView()
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
        self.configureInformationStackView()
        self.configureLogoutButton()
    }
}

//MARK: UI configuratrion
extension UserInformationView {
    private func configureContainerView() {
        self.addSubview(self.containerView)
        self.setContainerViewConstraints()
    }
    
    private func configureInformationStackView(){
        self.containerView.addSubview(self.informationStackView)
        self.setInformationStackViewConstraints()
    }
    
    private func configureLogoutButton(){
        self.containerView.addSubview(self.logoutButton)
        self.setLogoutButtonConstraints()
    }
}

//MARK: UI elements extension
extension UserInformationView {
    private func initContainerView() -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
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
extension UserInformationView {
    private func setContainerViewConstraints() {
        NSLayoutConstraint.activate([
            self.containerView.topAnchor.constraint(equalTo: self.topAnchor),
            self.containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            ])
    }
    
    private func setInformationStackViewConstraints() {
        NSLayoutConstraint.activate([
            self.informationStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            self.informationStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
            self.informationStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32),
            ])
    }
    
    private func setLogoutButtonConstraints() {
        NSLayoutConstraint.activate([
            self.logoutButton.topAnchor.constraint(equalTo: self.informationStackView.bottomAnchor, constant: 32),
            self.logoutButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.logoutButton.widthAnchor.constraint(equalToConstant: 254),
            self.logoutButton.heightAnchor.constraint(equalToConstant: 69)
            ])
    }
}


