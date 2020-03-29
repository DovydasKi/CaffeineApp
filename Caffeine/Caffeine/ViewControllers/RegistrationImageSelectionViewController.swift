//
//  RegistrationImageSelectionViewController.swift
//  Caffeine
//
//  Created by Daniel Dluzhnevsky on 2020-03-11.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation
import UIKit

class RegistrationImageSelectionViewController: UIViewController {
    private lazy var caffeineLogo: UIImageView = self.initCaffeineLogo()
    private lazy var infoLabel: UILabel = self.initInfoLabel()
    private lazy var firstProfileImage: UIImageView = self.initFirstProfileImage()
    private lazy var secondProfileImage: UIImageView = self.initSecondProfileImage()
    private lazy var thirdProfileImage: UIImageView = self.initThirdProfileImage()
    private lazy var fourthProfileImage: UIImageView = self.initFourthProfileImage()
    private lazy var fifthProfileImage: UIImageView = self.initFifthProfileImage()
    private lazy var sixthProfileImage: UIImageView = self.initSixthProfileImage()
    private lazy var profileImagesFirstRowStackView: UIStackView = self.initProfileImagesFirstRowStackView()
    private lazy var profileImagesSecondRowStackView: UIStackView = self.initProfileImagesSecondRowStackView()
    private lazy var profileImagesStackView: UIStackView = self.initProfileImagesStackView()
    private lazy var skipOrSelectButton: UIButton = self.initSkipButton()
    private lazy var imageDictionary = [self.firstProfileImage: false, self.secondProfileImage: false, self.thirdProfileImage: false, self.fourthProfileImage: false, self.fifthProfileImage: false, self.sixthProfileImage: false]

    private var registrationImageSelectionViewModel = RegistrationImageSelectionViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "orangeMain")
        navigationController?.navigationBar.isHidden = true

        self.view.addSubview(self.caffeineLogo)
        self.setCaffeineLogoConstraints(caffeineLogo)

        self.view.addSubview(self.infoLabel)
        self.setInfoLabelConstraints(self.infoLabel)

        self.view.addSubview(self.profileImagesStackView)
        self.setProfileImagesStackViewConstraints(self.profileImagesStackView)

        self.view.addSubview(self.skipOrSelectButton)
        self.setSkipButtonConstraints(self.skipOrSelectButton)
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

//MARK: Actions
extension RegistrationImageSelectionViewController {
    @objc private func turnOnHomeScreen() {
        let newUserMeetupTopicsVC = NewUserMeetupTopicsViewController()
        if self.skipOrSelectButton.currentTitle == "Praleisti" {
            self.navigationController?.pushViewController(newUserMeetupTopicsVC, animated: true)
            //self.navigationController?.setViewControllers([homeScreenVC], animated: true)
        }
        else {
            //TODO: set profile pic
        }
    }

    @objc private func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        self.imageDictionary = self.registrationImageSelectionViewModel.chooseImage(imageArray: &self.imageDictionary, tapGestureRecognizer: tapGestureRecognizer)
        self.changeSkipButtonTittle()
    }
}

extension RegistrationImageSelectionViewController {
    private func changeSkipButtonTittle() {
        if self.imageDictionary.contains(where: { $0.value == true }) {
            self.skipOrSelectButton.setTitle("Pasirinkti", for: .normal)
        }
        else {
            self.skipOrSelectButton.setTitle("Praleisti", for: .normal)
        }
    }
}

//MARK: UI elements extension
extension RegistrationImageSelectionViewController {
    private func initCaffeineLogo() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "bolt")
        imageView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }

    private func initInfoLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Bold", size: UIView.margin(of: [18, 22, 32]))
        label.text = "Išsirinkite paskyros nuotrauką"
        label.numberOfLines = 2
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.contentMode = .scaleAspectFit
        return label
    }

    private func initFirstProfileImage() -> UIImageView {
        let imageView = UIImageView()
        imageView.heightAnchor.constraint(equalToConstant: UIView.margin(of: [80, 80, 100])).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: UIView.margin(of: [80, 80, 100])).isActive = true
        imageView.image = #imageLiteral(resourceName: "profileImage")
        self.registrationImageSelectionViewModel.setShadow(imageView: imageView)

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        return imageView
    }

    private func initSecondProfileImage() -> UIImageView {
        let imageView = UIImageView()
        imageView.heightAnchor.constraint(equalToConstant: UIView.margin(of: [80, 80, 100])).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: UIView.margin(of: [80, 80, 100])).isActive = true
        imageView.image = #imageLiteral(resourceName: "profileImage2")
        self.registrationImageSelectionViewModel.setShadow(imageView: imageView)

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        return imageView
    }

    private func initThirdProfileImage() -> UIImageView {
        let imageView = UIImageView()
        imageView.heightAnchor.constraint(equalToConstant: UIView.margin(of: [80, 80, 100])).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: UIView.margin(of: [80, 80, 100])).isActive = true
        imageView.image = #imageLiteral(resourceName: "profileImage3")
        self.registrationImageSelectionViewModel.setShadow(imageView: imageView)

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        return imageView
    }

    private func initFourthProfileImage() -> UIImageView {
        let imageView = UIImageView()
        imageView.heightAnchor.constraint(equalToConstant: UIView.margin(of: [80, 80, 100])).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: UIView.margin(of: [80, 80, 100])).isActive = true
        imageView.image = #imageLiteral(resourceName: "profileImage4")
        self.registrationImageSelectionViewModel.setShadow(imageView: imageView)

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        return imageView
    }

    private func initFifthProfileImage() -> UIImageView {
        let imageView = UIImageView()
        imageView.heightAnchor.constraint(equalToConstant: UIView.margin(of: [80, 80, 100])).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: UIView.margin(of: [80, 80, 100])).isActive = true
        imageView.image = #imageLiteral(resourceName: "profileImage5")
        self.registrationImageSelectionViewModel.setShadow(imageView: imageView)

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        return imageView
    }

    private func initSixthProfileImage() -> UIImageView {
        let imageView = UIImageView()
        imageView.heightAnchor.constraint(equalToConstant: UIView.margin(of: [80, 80, 100])).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: UIView.margin(of: [80, 80, 100])).isActive = true
        imageView.image = #imageLiteral(resourceName: "profileImage6")
        self.registrationImageSelectionViewModel.setShadow(imageView: imageView)

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        return imageView
    }

    private func initProfileImagesFirstRowStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 16.0
        stackView.addArrangedSubview(self.firstProfileImage)
        stackView.addArrangedSubview(self.secondProfileImage)
        stackView.addArrangedSubview(self.thirdProfileImage)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }

    private func initProfileImagesSecondRowStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 16.0
        stackView.addArrangedSubview(self.fourthProfileImage)
        stackView.addArrangedSubview(self.fifthProfileImage)
        stackView.addArrangedSubview(self.sixthProfileImage)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }

    private func initProfileImagesStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 16.0
        stackView.addArrangedSubview(self.profileImagesFirstRowStackView)
        stackView.addArrangedSubview(self.profileImagesSecondRowStackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }

    public func initSkipButton() -> UIButton {
        let button: UIButton = UIButton(frame: CGRect(x: 56, y: 438, width: 304, height: 69))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 34.5
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.5
        button.backgroundColor = .white
        button.setTitle("Praleisti", for: .normal)
        button.setTitleColor(UIColor(named: "orangeMain"), for: .normal)
        button.titleLabel?.font = UIFont(name: "Rubik-Bold", size: UIView.margin(of: [24, 28, 32]))
        button.addTarget(self, action: #selector(self.turnOnHomeScreen), for: .touchUpInside)
        return button
    }
}

//MARK: Constraints extension
extension RegistrationImageSelectionViewController {
    private func setCaffeineLogoConstraints(_ caffeineLogo: UIImageView) {
        NSLayoutConstraint.activate([
            self.caffeineLogo.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: UIView.margin(of: [48.5, 72.75, 97.0])),
            self.caffeineLogo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.caffeineLogo.heightAnchor.constraint(equalToConstant: 90),
            self.caffeineLogo.widthAnchor.constraint(equalToConstant: 54)
        ])
    }

    private func setInfoLabelConstraints(_ infoLabel: UILabel) {
        NSLayoutConstraint.activate([
            self.infoLabel.topAnchor.constraint(equalTo: self.caffeineLogo.bottomAnchor, constant: UIView.margin(of: [32, 32, 64])),
            self.infoLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.infoLabel.heightAnchor.constraint(equalToConstant: 76),
            self.infoLabel.widthAnchor.constraint(equalToConstant: 378)
        ])
    }

    private func setProfileImagesStackViewConstraints(_ profileImagesStackView: UIStackView) {
        NSLayoutConstraint.activate([
            self.profileImagesStackView.topAnchor.constraint(equalTo: self.infoLabel.bottomAnchor, constant: UIView.margin(of: [32, 32, 64])),
            self.profileImagesStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ])
    }

    private func setSkipButtonConstraints(_ skipButton: UIButton) {
        NSLayoutConstraint.activate([
            self.skipOrSelectButton.topAnchor.constraint(equalTo: self.profileImagesStackView.bottomAnchor, constant: UIView.margin(of: [32, 32, 64])),
            self.skipOrSelectButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.skipOrSelectButton.widthAnchor.constraint(equalToConstant: 304),
            self.skipOrSelectButton.heightAnchor.constraint(equalToConstant: 69)
        ])
    }
}
