//
//  ProfileMeetupTopicsViewController.swift
//  Caffeine
//
//  Created by Daniel Dluzhnevsky on 2020-03-29.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation
import UIKit

class ProfileMeetupTopicsViewController: UIViewController{
    private lazy var profilePicture: UIImageView = self.initProfilePicture()
    private lazy var fullNameLabel: UILabel = self.initFullNameLabel()
    private lazy var menuBarView: UIView = self.initMenuBarView()

    private lazy var reservationButton: UIView = self.initReservationButton()
    private lazy var meetupTopicsButton: UIView = self.initMeetupTopicsButton()
    private lazy var informationButton: UIView = self.initInformationButton()
    
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
    }
}

//MARK: Button actions
extension ProfileMeetupTopicsViewController {
    @objc private func turnOnReservationScreen() {
        let newVC = ProfileReservationViewController()
        self.navigationController?.hero.isEnabled = true
        self.navigationController?.hero.navigationAnimationType = .selectBy(presenting: .slide(direction: .right), dismissing: .slide(direction: .right))
        self.navigationController?.viewControllers = [self]
        self.navigationController?.pushViewController(newVC, animated: true)
    }

    @objc private func turnOnInformationScreen() {
        
        let newVC = ProfileInformationViewController()
        self.navigationController?.hero.isEnabled = true
        self.navigationController?.hero.navigationAnimationType = .selectBy(presenting: .slide(direction: .left), dismissing: .slide(direction: .left))
        self.navigationController?.viewControllers = [self]
        self.navigationController?.pushViewController(newVC, animated: true)
    }
    
    
}

//MARK: UI elements extension
extension ProfileMeetupTopicsViewController {
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
        
        view.backgroundColor = .white
        view.layer.cornerRadius = 12.5
        
        label.font = UIFont(name: "Rubik-Bold", size: 14)
        label.text = "Pokalbio temos"
        label.textColor = .black
        label.textAlignment = .center
        view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
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
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.turnOnInformationScreen))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tap)
        return view
    }
}

//MARK: Constraints extension
extension ProfileMeetupTopicsViewController {
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
}
