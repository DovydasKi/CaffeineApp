//
//  LoginViewController.swift
//  Caffeine
//
//  Created by Dovydas Kiriliauskas on 2020-03-04.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    private lazy var arrowBackView: UIImageView = self.initArrowBackView()
    private lazy var caffeineLogo: UIImageView = self.initCaffeineLogo()
    private lazy var loginTitle: UILabel = self.initLoginTitleView()
    private lazy var emailField: UITextField = self.initLoginTextField()
    private lazy var passwordField: UITextField = self.initPasswordTextField()
    private lazy var dontHaveAccountTextLabel: UILabel = self.dontHaveAccountTextLabelView()
    private lazy var forgotPasswordTextLabel: UILabel = self.forgotPasswordTextLabelView()
    private lazy var loginButton: UIButton = self.initloginButton()
    private lazy var wrongInputPromt: UILabel = self.wrongInputPromtLabelView()
    private lazy var timerForPromt: Timer = self.initTimerForPromt()
    private var loginViewModel = LoginViewModel()
    private var textFieldConnectFields = TextFieldConnectFields()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "orangeMain")
        navigationController?.navigationBar.isHidden = true
        
        self.view.addSubview(self.arrowBackView)
        self.activateArrowBackConstraints()

        self.view.addSubview(self.caffeineLogo)
        self.activateIconConstraints()

        self.view.addSubview(self.loginTitle)
        self.activateLoginTitleConstraints()

        self.view.addSubview(self.emailField)
        self.activateEmailFieldConstraints()

        self.view.addSubview(self.passwordField)
        self.activatePasswordFielConstraints()

        self.view.addSubview(self.dontHaveAccountTextLabel)
        self.activateDontHaveAccounttextLabelConstraints()

        self.view.addSubview(self.forgotPasswordTextLabel)
        self.activateForgotPasswordConstraints()

        self.view.addSubview(self.loginButton)
        self.activateLoginButtonConstraints()

        self.textFieldConnectFields.connectFields(fields: [self.emailField, self.passwordField])
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

//MARK: Button actions
extension LoginViewController {
    @objc private func backToMainScreen() {
        let newVC = MainScreenViewController()
        self.navigationController?.setViewControllers([newVC], animated: true)
    }
    @objc private func turnOnRegisterScreen() {
        let newVC = RegisterScreenViewController()
        self.navigationController?.setViewControllers([newVC], animated: true)
    }

    @objc private func turnOnHomeScreen() {
        self.wrongInputPromt.removeFromSuperview()
        self.timerForPromt.invalidate()

        if self.loginViewModel.checkForAllValidFields(emailField: self.emailField, passwordField: self.passwordField) == true {
            let homeScreenVC = HomeScreenViewController()
            self.navigationController?.setViewControllers([homeScreenVC], animated: true)
        }
        else {
            self.view.addSubview(self.wrongInputPromt)
            self.activateWrongInputPromtLabelViewConstraints()
            self.timerForPromt = initTimerForPromt()
        }
    }
}

extension LoginViewController {
    @objc private func dismissInvalidInputPromt() {
        self.wrongInputPromt.removeFromSuperview()
    }
}

//MARK: UI elements extension
extension LoginViewController {
    private func initLoginTitleView() -> UILabel {
        let label = UILabel()
        label.text = "Prisijungimas"
        label.font = UIFont(name: "Rubik-Black", size: 40)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }

    private func initLoginTextField() -> UITextField {
        let textField = UITextField()
        textField.backgroundColor = UIColor(named: "orangeMain")
        textField.placeholder = "El.paštas"
        textField.textColor = .white
        textField.textAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.init(name: "Rubik-Black", size: UIView.margin(of: [18, 20, 24]))

        let bottomBorder = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        bottomBorder.backgroundColor = UIColor.white
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        textField.addSubview(bottomBorder)
        bottomBorder.bottomAnchor.constraint(equalTo: textField.bottomAnchor, constant: 3).isActive = true
        bottomBorder.leftAnchor.constraint(equalTo: textField.leftAnchor).isActive = true
        bottomBorder.rightAnchor.constraint(equalTo: textField.rightAnchor).isActive = true
        bottomBorder.heightAnchor.constraint(equalToConstant: 2).isActive = true
        return textField
    }

    private func initPasswordTextField() -> UITextField {
        let textField = UITextField()
        textField.backgroundColor = UIColor(named: "orangeMain")
        textField.placeholder = "Slaptažodis"
        textField.textColor = .white
        textField.textAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.init(name: "Rubik-Black", size: UIView.margin(of: [18, 20, 24]))
        textField.textContentType = .oneTimeCode
        textField.isSecureTextEntry = true

        let bottomBorder = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        bottomBorder.backgroundColor = UIColor.white
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        textField.addSubview(bottomBorder)
        bottomBorder.bottomAnchor.constraint(equalTo: textField.bottomAnchor, constant: 3).isActive = true
        bottomBorder.leftAnchor.constraint(equalTo: textField.leftAnchor).isActive = true
        bottomBorder.rightAnchor.constraint(equalTo: textField.rightAnchor).isActive = true
        bottomBorder.heightAnchor.constraint(equalToConstant: 2).isActive = true
        return textField
    }

    private func dontHaveAccountTextLabelView() -> UILabel {
        let label = UILabel()
        label.text = "Neturite paskyros?\nUžsiregistruokite!"
        label.font = UIFont(name: "Rubik-Medium", size: UIView.margin(of: [14, 16, 18]))
        label.textColor = .white
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center

        let tap = UITapGestureRecognizer(target: self, action: #selector(turnOnRegisterScreen))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tap)
        return label
    }

    private func forgotPasswordTextLabelView() -> UILabel {
        let label = UILabel()
        label.text = "Pamiršote slaptažodį?"
        label.font = UIFont(name: "Rubik-Medium", size: UIView.margin(of: [14, 16, 18]))
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }

    private func initloginButton() -> UIButton {
        let button: UIButton = UIButton(frame: CGRect(x: 56, y: 438, width: 304, height: 69))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 34.5
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.5
        button.backgroundColor = .white
        button.setTitle("Prisijungti", for: .normal)
        button.setTitleColor(UIColor(named: "orangeMain"), for: .normal)
        button.titleLabel?.font = UIFont(name: "Rubik-Bold", size: UIView.margin(of: [24, 28, 32]))
        button.addTarget(self, action: #selector(self.turnOnHomeScreen), for: .touchUpInside)
        return button
    }

    private func initCaffeineLogo() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "bolt")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: 120, height: 120)
        return imageView
    }

    private func wrongInputPromtLabelView() -> UILabel {
        let label = UILabel()
        label.text = "Neteisingas El.paštas arba slaptažodis"
        label.font = UIFont(name: "Rubik-Medium", size: UIView.margin(of: [10, 12, 14]))
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }

    private func initTimerForPromt() -> Timer {
        var timer = Timer()
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(3.0), target: self, selector: #selector(dismissInvalidInputPromt), userInfo: nil, repeats: true)
        return timer
    }

    private func initArrowBackView() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "arrowBack")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.frame = CGRect(x: 44, y: 50, width: 34, height: 55)
        imageView.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(backToMainScreen))
        imageView.addGestureRecognizer(tapRecognizer)
        return imageView
    }
}

//MARK: Constraints extension
extension LoginViewController {
    private func activateArrowBackConstraints() {
        NSLayoutConstraint.activate([
            self.arrowBackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16),
            self.arrowBackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32.0),
            self.arrowBackView.heightAnchor.constraint(equalToConstant: 32)
            ])
    }

    private func activateIconConstraints() {
        NSLayoutConstraint.activate([
            self.caffeineLogo.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.caffeineLogo.topAnchor.constraint(equalTo: self.arrowBackView.bottomAnchor, constant: 20),
            self.caffeineLogo.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: UIView.margin(of: [42.0, 63.0, 84.0])),
            self.caffeineLogo.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -UIView.margin(of: [42.0, 63.0, 84.0])),
            self.caffeineLogo.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: UIView.margin(of: [146.5, 146.5, 146.5]))
        ])
    }

    private func activateLoginTitleConstraints() {
        NSLayoutConstraint.activate([
            self.loginTitle.topAnchor.constraint(equalTo: self.caffeineLogo.bottomAnchor, constant: UIView.margin(of: [5, 10, 20])),
            self.loginTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.loginTitle.heightAnchor.constraint(equalToConstant: UIView.margin(of: [47, 47, 47])),
            self.loginTitle.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)])
    }

    private func activateEmailFieldConstraints() {
        NSLayoutConstraint.activate([
            self.emailField.topAnchor.constraint(equalTo: self.loginTitle.bottomAnchor, constant: UIView.margin(of: [19.625, 39.25, 78.5])),
            self.emailField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 64.0),
            self.emailField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -64.0)
        ])
    }

    private func activateDontHaveAccounttextLabelConstraints() {
        NSLayoutConstraint.activate([
            self.dontHaveAccountTextLabel.topAnchor.constraint(equalTo: self.passwordField.bottomAnchor, constant: 40.0),
            self.dontHaveAccountTextLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 64.0),
            self.dontHaveAccountTextLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -64.0)
        ])
    }

    private func activateForgotPasswordConstraints() {
        NSLayoutConstraint.activate([
            self.forgotPasswordTextLabel.topAnchor.constraint(equalTo: self.dontHaveAccountTextLabel.bottomAnchor, constant: 32.0),
            self.forgotPasswordTextLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 64.0),
            self.forgotPasswordTextLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -64.0)
        ])
    }

    private func activateLoginButtonConstraints() {
        NSLayoutConstraint.activate([
            self.loginButton.topAnchor.constraint(equalTo: self.forgotPasswordTextLabel.bottomAnchor, constant: 40.0),
            self.loginButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 55.0),
            self.loginButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -55.0),
            self.loginButton.heightAnchor.constraint(equalToConstant: 69.0)
        ])
    }

    private func activatePasswordFielConstraints() {
        NSLayoutConstraint.activate([
            self.passwordField.topAnchor.constraint(equalTo: self.emailField.bottomAnchor, constant: 50.0),
            self.passwordField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 64.0),
            self.passwordField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -64.0)
        ])
    }

    private func activateWrongInputPromtLabelViewConstraints() {
        NSLayoutConstraint.activate([
            self.wrongInputPromt.topAnchor.constraint(equalTo: self.loginButton.bottomAnchor, constant: 32.0),
            self.wrongInputPromt.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 64.0),
            self.wrongInputPromt.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -64.0)
        ])
    }
}
