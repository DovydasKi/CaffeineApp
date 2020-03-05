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

    lazy var loginTitle: UILabel = self.initLoginTitleView()
    lazy var emailField: UITextField = self.initLoginTextField()
    lazy var passwordField: UITextField = self.initPasswordTextField()
    lazy var dontHaveAccountTextLabel: UILabel = self.dontHaveAccountTextLabelView()
    lazy var forgotPasswordTextLabel: UILabel = self.forgotPasswordTextLabelView()
    lazy var loginButton: UIButton = self.initloginButton()
    lazy var icon: UIImageView = self.initIcon()
    lazy var arrowBackView: UIImageView = self.initArrowBackView()
    var loginViewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = UIColor(named: "orangeMain")
        self.view.addSubview(self.arrowBackView)
        self.activateArrowBackConstraints()

        self.view.addSubview(self.icon)
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

        UITextField.connectFields(fields: [self.emailField, self.passwordField])

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

    @objc private func turnOnHomeScreen() {
        if loginViewModel.checkForInvalidInut(self.emailField) == true {
            print("I was inside: bad input")
            self.showAlertButtonTapped(self.loginButton)
            self.emailField.text = ""
            self.passwordField.text = ""
        }
        else {
            print("I was inside: good input")
            //navigate to next screen
        }
    }

}

//MARK: UXTextField extension
extension UITextField {
    class func connectFields(fields: [UITextField]) -> Void {
        guard let last = fields.last else {
            return
        }
        for i in 0 ..< fields.count - 1 {
            fields[i].returnKeyType = .next
            fields[i].addTarget(fields[i + 1], action: #selector(UIResponder.becomeFirstResponder), for: .editingDidEndOnExit)
        }
        last.returnKeyType = .done
        last.addTarget(last, action: #selector(UIResponder.resignFirstResponder), for: .editingDidEndOnExit)
    }
}

//MARK: Checking for valid input
extension LoginViewController {
    private func showAlertButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Klaida!", message: "Neteisingas El.paštas arba slaptažodis", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
        textField.font = UIFont.init(name: "Rubik-Black", size: 24.0)

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
        textField.font = UIFont.init(name: "Rubik-Black", size: 24.0)

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
        label.font = UIFont(name: "Rubik-Medium", size: 18)
        label.textColor = .white
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center

        return label
    }

    private func forgotPasswordTextLabelView() -> UILabel {
        let label = UILabel()
        label.text = "Pamiršote slaptažodį?"
        label.font = UIFont(name: "Rubik-Medium", size: 18)
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
        button.layer.shadowRadius = 4 // blur
        button.layer.shadowOpacity = 0.5
        button.backgroundColor = .white
        button.setTitle("Prisijungti", for: .normal)
        button.setTitleColor(UIColor(named: "orangeMain"), for: .normal)
        button.titleLabel?.font = UIFont(name: "Rubik-Bold", size: 32)
        button.addTarget(self, action: #selector(turnOnHomeScreen), for: .touchUpInside)

        return button
    }

    private func initIcon() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "bolt")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)

        return imageView
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
            self.arrowBackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32.0)])
    }

    private func activateIconConstraints() {
        NSLayoutConstraint.activate([
            self.icon.topAnchor.constraint(equalTo: self.arrowBackView.bottomAnchor, constant: 20),
            self.icon.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -180),
            self.icon.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 180),
            self.icon.heightAnchor.constraint(equalToConstant: 90)])
    }

    private func activateLoginTitleConstraints() {
        NSLayoutConstraint.activate([
            self.loginTitle.topAnchor.constraint(equalTo: self.icon.bottomAnchor, constant: 42.0),
            self.loginTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.loginTitle.heightAnchor.constraint(equalToConstant: 47),
            self.loginTitle.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)])
    }

    private func activateEmailFieldConstraints() {
        NSLayoutConstraint.activate([
            self.emailField.topAnchor.constraint(equalTo: self.loginTitle.bottomAnchor, constant: 130),
            self.emailField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 64.0),
            self.emailField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -64.0)])
    }

    private func activateDontHaveAccounttextLabelConstraints() {
        NSLayoutConstraint.activate([
            self.dontHaveAccountTextLabel.topAnchor.constraint(equalTo: self.passwordField.bottomAnchor, constant: 40.0),
            self.dontHaveAccountTextLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 64.0),
            self.dontHaveAccountTextLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -64.0)])
    }

    private func activateForgotPasswordConstraints() {
        NSLayoutConstraint.activate([
            self.forgotPasswordTextLabel.topAnchor.constraint(equalTo: self.dontHaveAccountTextLabel.bottomAnchor, constant: 32.0),
            self.forgotPasswordTextLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 64.0),
            self.forgotPasswordTextLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -64.0)])
    }

    private func activateLoginButtonConstraints() {
        NSLayoutConstraint.activate([
            self.loginButton.topAnchor.constraint(equalTo: self.forgotPasswordTextLabel.bottomAnchor, constant: 40.0),
            self.loginButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 55.0),
            self.loginButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -55.0),
            self.loginButton.heightAnchor.constraint(equalToConstant: 69.0)])
    }

    private func activatePasswordFielConstraints() {
        NSLayoutConstraint.activate([
            self.passwordField.topAnchor.constraint(equalTo: self.emailField.bottomAnchor, constant: 50.0),
            self.passwordField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 64.0),
            self.passwordField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -64.0)])
    }
}
