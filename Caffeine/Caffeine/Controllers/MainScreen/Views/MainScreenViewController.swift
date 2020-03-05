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
    
    private lazy var caffeineLabel: UILabel = self.initCaffeineLabel("Caffeine")
    private lazy var caffeineLogo: UIImageView = self.initCaffeineLogo()
    private lazy var loginButton: UIButton = self.initLoginInButton("Prisijungti")
    private lazy var getStartedButton: UIButton = self.initGetStartedButton("Registruotis")
    
    fileprivate func setCaffeineLogoConstraints(_ caffeineLogo: UIImageView) {
        NSLayoutConstraint.activate([
            self.caffeineLogo.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 91.5),
            self.caffeineLogo.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 158.5),
            self.caffeineLogo.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -158.5),
            self.caffeineLogo.heightAnchor.constraint(equalToConstant: 165)
            
        ])
    }
    
    fileprivate func setCaffeineLabelConstraints(_ caffeineLabel: UILabel) {
        
        NSLayoutConstraint.activate([
            self.caffeineLabel.topAnchor.constraint(equalTo: self.caffeineLogo.bottomAnchor, constant: 26.5),
            self.caffeineLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 58.5),
            self.caffeineLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -58.5),
            self.caffeineLabel.heightAnchor.constraint(equalToConstant: 65)
        ])
    }
    
    fileprivate func setLoginButtonConstraints(_ loginButton: UIButton) {
        NSLayoutConstraint.activate([
            self.loginButton.topAnchor.constraint(equalTo: self.caffeineLabel.bottomAnchor, constant: 103),
            self.loginButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 55),
            self.loginButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -55)
        ])
    }
    
    fileprivate func setGetStartedButtonConstraints(_ getStartedButton: UIButton) {
        NSLayoutConstraint.activate([
            self.getStartedButton.topAnchor.constraint(equalTo: self.caffeineLabel.bottomAnchor, constant: 232),
            self.getStartedButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 55),
            self.getStartedButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -55)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "orangeMain")
        navigationController?.navigationBar.isHidden = true
        
        self.view.addSubview(self.caffeineLogo)
        setCaffeineLogoConstraints(self.caffeineLogo)
        
        self.view.addSubview(self.caffeineLabel)
        setCaffeineLabelConstraints(self.caffeineLabel)
        
        self.view.addSubview(self.loginButton)
        setLoginButtonConstraints(self.loginButton)
        
        self.view.addSubview(self.getStartedButton)
        setGetStartedButtonConstraints(self.getStartedButton)
        
    }
}

extension MainScreenViewController {
    
    private func initCaffeineLogo() -> UIImageView {
        let image = UIImage(named: "bolt.png")
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: 0, y: 0, width: 97, height: 80)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    private func initCaffeineLabel(_ title: String) -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Bold", size: 54)
        label.text = title
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }
    
    private func initLoginInButton(_ title: String) -> UIButton {
        let button:UIButton = UIButton(frame: CGRect(x: 56, y: 438, width: 304, height: 69))
        button.layer.cornerRadius = 34.5
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 4 // blur
        button.layer.shadowOpacity = 0.5
        button.backgroundColor = .white
        button.setTitle(title, for: .normal )
        button.setTitleColor(UIColor(named: "orangeMain"), for: .normal)
        button.titleLabel?.font = UIFont(name: "Rubik-Bold", size: 32)
        return button
    }
    
    private func initGetStartedButton(_ title: String) -> UIButton {
        let button: UIButton = UIButton(frame: CGRect(x: 56, y: 539, width: 304, height: 69))
        button.layer.cornerRadius = 34.5
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 4 // blur
        button.layer.shadowOpacity = 0.5
        button.backgroundColor = .white
        button.setTitle(title, for: .normal )
        button.setTitleColor(UIColor(named: "orangeMain"), for: .normal)
        button.titleLabel?.font = UIFont(name: "Rubik-Bold", size: 32)
        return button
    }
    
}
