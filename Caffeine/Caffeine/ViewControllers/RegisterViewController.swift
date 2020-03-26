//
//  RegisterScreenController.swift
//  Caffeine
//
//  Created by Daniel Dluzhnevsky on 2020-03-06.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation
import UIKit

class RegisterScreenViewController: UIViewController {
    private lazy var arrowBackView: UIImageView = self.initArrowBackView()
    private lazy var caffeineLogo: UIImageView = self.initCaffeineLogo()
    private lazy var signUpTitle: UILabel = self.initSignUpTitleView()
    private lazy var fullNameField: UITextField = self.initFullNameTextField()
    private lazy var userNameField: UITextField = self.initUserNameTextField()
    private lazy var emailField: UITextField = self.initEmailTextField()
    private lazy var passwordField: UITextField = self.initPasswordTextField()
    private lazy var passwordRequirement: UILabel = self.initPasswordRequirementLabelView()
    private lazy var passwordRequirementCheckMark: UIImageView = self.initPasswordRequirementCheckMarkLabelView()
    private lazy var createAccoutButton: UIButton = self.initCreateAccoutButton()
    private lazy var disclaimer: UILabel = self.initDisclaimerLabelView()
    private var registerViewModel = RegisterViewModel()
    private var textFieldConnectFields = TextFieldConnectFields()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "orangeMain")
        navigationController?.navigationBar.isHidden = true
        
        self.view.addSubview(self.arrowBackView)
        self.activateArrowBackConstraints()

        self.view.addSubview(self.caffeineLogo)
        self.activateIconConstraints()

        self.view.addSubview(self.signUpTitle)
        self.activateSignUpTitleConstraints()

        self.view.addSubview(self.fullNameField)
        self.activateFullNameFieldConstraints()

        self.view.addSubview(self.userNameField)
        self.activateUserNameFieldConstraints()

        self.view.addSubview(self.emailField)
        self.activateEmailFieldConstraints()

        self.view.addSubview(self.passwordField)
        self.activatePasswordFieldConstraints()

        self.view.addSubview(self.passwordRequirement)
        self.activatePasswordRequirementConstraints()

        self.view.addSubview(self.passwordRequirementCheckMark)
        self.activatePasswordRequirementCheckMarkConstraints()

        self.view.addSubview(self.createAccoutButton)
        self.activateCreateAccoutButtonConstraints()

        self.view.addSubview(self.disclaimer)
        self.activateDisclaimerConstraints()

        self.textFieldConnectFields.connectFields(fields: [self.fullNameField, self.userNameField, self.emailField, self.passwordField])
        self.passwordField.addTarget(self, action: #selector(self.checkForInvalidInut(_:)), for: UIControl.Event.editingChanged)

        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		UIApplication.shared.setStatusBarStyle(.default, animated: animated)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		UIApplication.shared.setStatusBarStyle(.lightContent, animated: animated)
	}
}

//MARK: Button actions
extension RegisterScreenViewController {
    @objc private func backToMainScreen() {
        let newVC = MainScreenViewController()
        self.navigationController?.setViewControllers([newVC], animated: true)
    }
    @objc private func turnOnSecondRegisterScreen() {
        if self.registerViewModel.checkForAllValidFields(fullNameField: self.fullNameField, userNameField: self.userNameField, emailField: self.emailField, passwordField: self.passwordField) == true {
            let secondRegisterScreen = RegistrationConfirmationViewController()
            self.navigationController?.setViewControllers([secondRegisterScreen], animated: true)
        }
    }
}

//MARK: Checking for valid input
extension RegisterScreenViewController {
    @objc private func checkForInvalidInut(_ passwordInput: UITextField) {
        self.registerViewModel.checkForValidPassword(passwordInput: passwordInput, passwordRequirementCheckMark: self.passwordRequirementCheckMark)
    }
    private func showAlertButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Klaida!", message: "Neteisingas El.paštas", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

//TODO: Extect to seperate controller?
//MARK: Dynamic view
extension RegisterScreenViewController {
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height - 84
            }
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}

//MARK: UI elements extension
extension RegisterScreenViewController {

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

    private func initCaffeineLogo() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "bolt")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: 120, height: 120)
        return imageView
    }

    private func initSignUpTitleView() -> UILabel {
        let label = UILabel()
        label.text = "Registracija"
        label.font = UIFont(name: "Rubik-Black", size: 40)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }

    private func initFullNameTextField() -> UITextField {
        let textField = UITextField()
        textField.backgroundColor = UIColor(named: "orangeMain")
        textField.placeholder = "Vardas Pavardė"
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

    private func initUserNameTextField() -> UITextField {
        let textField = UITextField()
        textField.backgroundColor = UIColor(named: "orangeMain")
        textField.placeholder = "Naudotojo vardas"
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

    private func initEmailTextField() -> UITextField {
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

    private func initPasswordRequirementLabelView() -> UILabel {
        let label = UILabel()
        label.text = "5 simboliai slaptažodyje"
        label.font = UIFont(name: "Rubik-Medium", size: UIView.margin(of: [10, 12, 14]))
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.preferredMaxLayoutWidth = 162
        return label
    }

    private func initPasswordRequirementCheckMarkLabelView() -> UIImageView {
        let checkMark = UIImageView()
        checkMark.backgroundColor = UIColor.white
        checkMark.frame = CGRect(x: 0, y: 0, width: 18, height: 18)
        checkMark.layer.cornerRadius = checkMark.frame.size.width / 2
        checkMark.translatesAutoresizingMaskIntoConstraints = false
        checkMark.clipsToBounds = true
        return checkMark
    }

    private func initCreateAccoutButton() -> UIButton {
        let button: UIButton = UIButton(frame: CGRect(x: 56, y: 438, width: 304, height: 69))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 34.5
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 4 // blur
        button.layer.shadowOpacity = 0.5
        button.backgroundColor = .white
        button.setTitle("Sukurti paskyrą", for: .normal)
        button.setTitleColor(UIColor(named: "orangeMain"), for: .normal)
        button.titleLabel?.font = UIFont(name: "Rubik-Bold", size: UIView.margin(of: [24, 28, 32]))
        button.addTarget(self, action: #selector(self.turnOnSecondRegisterScreen), for: .touchUpInside)
        return button
    }

    private func initDisclaimerLabelView() -> UILabel {
        let label = UILabel()
        label.text = "Sukurdami paskyrą sutinkate su mūsų paslaugų tiekimo ir privatumo politika"
        label.numberOfLines = 2
        label.font = UIFont(name: "Rubik-Medium", size: UIView.margin(of: [9, 10, 12]))
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }
}

//MARK: Constraints extension
extension RegisterScreenViewController {
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

    private func activateSignUpTitleConstraints() {
        NSLayoutConstraint.activate([
            self.signUpTitle.topAnchor.constraint(equalTo: self.caffeineLogo.bottomAnchor, constant: UIView.margin(of: [5, 10, 20])),
            self.signUpTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.signUpTitle.heightAnchor.constraint(equalToConstant: UIView.margin(of: [47, 47, 47])),
            self.signUpTitle.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)
        ])
    }

    private func activateFullNameFieldConstraints() {
        NSLayoutConstraint.activate([
            self.fullNameField.topAnchor.constraint(equalTo: self.signUpTitle.bottomAnchor, constant: UIView.margin(of: [19.625, 39.25, 78.5])),
            self.fullNameField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 64.0),
            self.fullNameField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -64.0)
        ])
    }

    private func activateUserNameFieldConstraints() {
        NSLayoutConstraint.activate([
            self.userNameField.topAnchor.constraint(equalTo: self.fullNameField.bottomAnchor, constant: UIView.margin(of: [12.5, 25, 50])),
            self.userNameField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 64.0),
            self.userNameField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -64.0)
        ])
    }

    private func activateEmailFieldConstraints() {
        NSLayoutConstraint.activate([
            self.emailField.topAnchor.constraint(equalTo: self.userNameField.bottomAnchor, constant: UIView.margin(of: [12.5, 25, 50])),
            self.emailField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 64.0),
            self.emailField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -64.0)
        ])
    }

    private func activatePasswordFieldConstraints() {
        NSLayoutConstraint.activate([
            self.passwordField.topAnchor.constraint(equalTo: self.emailField.bottomAnchor, constant: UIView.margin(of: [12.5, 25, 50])),
            self.passwordField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 64.0),
            self.passwordField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -64.0)
        ])
    }

    private func activatePasswordRequirementConstraints() {
        NSLayoutConstraint.activate([
            self.passwordRequirement.topAnchor.constraint(equalTo: self.passwordField.bottomAnchor, constant: 32),
            self.passwordRequirement.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 137.5),
            self.passwordRequirement.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -84.5),
            self.passwordRequirement.heightAnchor.constraint(equalToConstant: 17)
        ])
    }

    private func activatePasswordRequirementCheckMarkConstraints() {
        NSLayoutConstraint.activate([
            self.passwordRequirementCheckMark.topAnchor.constraint(equalTo: self.passwordField.bottomAnchor, constant: 32),
            self.passwordRequirementCheckMark.trailingAnchor.constraint(equalTo: self.passwordRequirement.leadingAnchor, constant: -22.5),// cia
            self.passwordRequirementCheckMark.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 97),
            self.passwordRequirementCheckMark.heightAnchor.constraint(equalToConstant: 18)
        ])
    }

    private func activateCreateAccoutButtonConstraints() {
        NSLayoutConstraint.activate([
            self.createAccoutButton.topAnchor.constraint(equalTo: self.passwordRequirement.bottomAnchor, constant: 32),
            self.createAccoutButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 55.0),
            self.createAccoutButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -55.0),
            self.createAccoutButton.heightAnchor.constraint(equalToConstant: 69)
        ])
    }

    private func activateDisclaimerConstraints() {
        NSLayoutConstraint.activate([
            self.disclaimer.topAnchor.constraint(equalTo: self.createAccoutButton.bottomAnchor, constant: 32),
            self.disclaimer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 95.0),
            self.disclaimer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -95.0),
            self.disclaimer.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
}
