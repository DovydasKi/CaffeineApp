//
//  MainScreenViewController.swift
//  Caffeine
//
//  Created by Dovydas Kiriliauskas on 2020-03-04.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation
import UIKit

class MainScreenViewController: UIViewController {
    private lazy var caffeineLabel: UILabel = self.initCaffeineLabel()
    private lazy var caffeineLogo: UIImageView = self.initCaffeineLogo()
    private lazy var loginButton: UIButton = self.initLoginInButton()
    private lazy var getStartedButton: UIButton = self.initGetStartedButton()
    private var mainScreenViewModel = MainScreenViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "orangeMain")
        navigationController?.navigationBar.isHidden = true

        self.view.addSubview(self.caffeineLogo)
        self.activateCaffeineLogoConstraints()

        self.view.addSubview(self.caffeineLabel)
        self.activateCaffeineLabelConstraints()

        self.view.addSubview(self.loginButton)
        self.activateLoginButtonConstraints()

        self.view.addSubview(self.getStartedButton)
        self.activateGetStartedButtonConstraints()
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

extension MainScreenViewController {
    @objc private func turnOnLoginScreen() {
        let newVC = LoginViewController()
        self.navigationController?.setViewControllers([newVC], animated: true)
    }

    @objc private func turnOnRegisterScreen() {
        let newVC = RegisterScreenViewController()
        self.navigationController?.setViewControllers([newVC], animated: true)
    }
}

//MARK: UI elements extension
extension MainScreenViewController {
    private func initCaffeineLogo() -> UIImageView {
        let image = #imageLiteral(resourceName: "bolt")
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: 120, height: 120)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }

    private func initCaffeineLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Bold", size: 54)
        label.text = self.mainScreenViewModel.caffeineLabelTitle
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.contentMode = .scaleAspectFit
        return label
    }

    private func initLoginInButton() -> UIButton {
        let button: UIButton = UIButton()
        button.layer.cornerRadius = 34.5
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.5
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(self.mainScreenViewModel.loginButtonTitle, for: .normal)
        button.setTitleColor(UIColor(named: "orangeMain"), for: .normal)
        button.titleLabel?.font = UIFont(name: "Rubik-Bold", size: 32)
        button.addTarget(self, action: #selector(turnOnLoginScreen), for: .touchUpInside)
        return button
    }

    private func initGetStartedButton() -> UIButton {
        let button: UIButton = UIButton()
        button.layer.cornerRadius = 34.5
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.5
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(self.mainScreenViewModel.getStartedButtonTitle, for: .normal)
        button.setTitleColor(UIColor(named: "orangeMain"), for: .normal)
        button.titleLabel?.font = UIFont(name: "Rubik-Bold", size: 32)
        button.addTarget(self, action: #selector(turnOnRegisterScreen), for: .touchUpInside)
        return button
    }
}

//MARK: Constraints extension
extension MainScreenViewController {
    private func activateCaffeineLogoConstraints() {
        NSLayoutConstraint.activate([
            self.caffeineLogo.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.caffeineLogo.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: UIView.margin(of: [48.5, 72.75, 97.0])),
            self.caffeineLogo.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: UIView.margin(of: [42.0, 63.0, 84.0])),
            self.caffeineLogo.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -UIView.margin(of: [42.0, 63.0, 84.0])),
            self.caffeineLogo.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: UIView.margin(of: [100, 220.0, 300.0]))
            ])
    }

    private func activateCaffeineLabelConstraints() {
        NSLayoutConstraint.activate([
            self.caffeineLabel.topAnchor.constraint(equalTo: self.caffeineLogo.bottomAnchor, constant: UIView.margin(of: [7.5, 13.25, 26.5])),
            self.caffeineLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: UIView.margin(of: [14.5, 29.25, 58.5])),
            self.caffeineLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -UIView.margin(of: [14.5, 29.25, 58.5])),
            self.caffeineLabel.bottomAnchor.constraint(equalTo: self.caffeineLogo.bottomAnchor, constant: UIView.margin(of: [21, 55, 80.5]))
            ])
    }

    private func activateLoginButtonConstraints() {
        NSLayoutConstraint.activate([
            self.loginButton.heightAnchor.constraint(equalToConstant: 69),
            self.loginButton.widthAnchor.constraint(equalToConstant: UIView.margin(of: [16, 152.0, 304.0])),
            self.loginButton.topAnchor.constraint(equalTo: self.caffeineLabel.bottomAnchor, constant: UIView.margin(of: [16, 70, 103.0])),
            self.loginButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: UIView.margin(of: [16, 30, 55.0])),
            self.loginButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -UIView.margin(of: [16, 30, 55.0]))
            ])
    }

    private func activateGetStartedButtonConstraints() {
        NSLayoutConstraint.activate([
            self.getStartedButton.heightAnchor.constraint(equalToConstant: 69),
            self.getStartedButton.widthAnchor.constraint(equalToConstant: UIView.margin(of: [16, 152.0, 304.0])),
            self.getStartedButton.topAnchor.constraint(equalTo: self.loginButton.bottomAnchor, constant: UIView.margin(of: [15, 30, 60])),
            self.getStartedButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: UIView.margin(of: [16, 30, 55.0])),
            self.getStartedButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -UIView.margin(of: [16, 30, 55.0]))
            ])
    }
}

