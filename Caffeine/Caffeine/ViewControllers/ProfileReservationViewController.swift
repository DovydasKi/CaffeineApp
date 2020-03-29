//
//  ProfileReservationViewController.swift
//  Caffeine
//
//  Created by Daniel Dluzhnevsky on 2020-03-18.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation
import UIKit
import Hero


class UserModal {
    var userImage: UIImage?
    var name: String?
    var meetupPurpose: String?
    var address: String?
    var dateAndTime: String?

    init(userImage: UIImage, name: String, meetupPurpose: String, address: String, dateAndTime: String) {
        self.userImage = userImage
        self.name = name
        self.meetupPurpose = meetupPurpose
        self.address = address
        self.dateAndTime = dateAndTime
    }
}

class ProfileReservationViewController: UIViewController {
    private lazy var profilePicture: UIImageView = self.initProfilePicture()
    private lazy var fullNameLabel: UILabel = self.initFullNameLabel()
    private lazy var menuBarView: UIView = self.initMenuBarView()

    private lazy var reservationButton: UIView = self.initReservationButton()
    private lazy var meetupTopicsButton: UIView = self.initMeetupTopicsButton()
    private lazy var informationButton: UIView = self.initInformationButton()

    private lazy var tableViewScrollView: UIScrollView = self.intiTableViewScrollView()
    private lazy var tableView: UITableView = self.initTableView()
    private lazy var userArr = [UserModal]()

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

        self.view.addSubview(self.tableViewScrollView)
        self.tableViewScrollView.showsVerticalScrollIndicator = false
        self.setTableViewScrollViewConstraints()

    }
}

extension ProfileReservationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ProfileReservationCustomTableViewCell else { fatalError("Unabel to create cell") }
        cell.userImage.image = self.userArr[indexPath.row].userImage
        cell.namelabel.text = self.userArr[indexPath.row].name
        cell.meetupPurposeLabel.text = self.userArr[indexPath.row].meetupPurpose
        cell.addressLabel.text = self.userArr[indexPath.row].address
        cell.dateAndTimeLabel.text = self.userArr[indexPath.row].dateAndTime
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}

//MARK: Button actions
extension ProfileReservationViewController {
    @objc private func turnOnMeetupTopicsScreen() {
        let newVC = ProfileMeetupTopicsViewController()
        self.navigationController?.hero.isEnabled = true
        self.navigationController?.hero.navigationAnimationType = .selectBy(presenting: .slide(direction: .left), dismissing: .slide(direction: .left))
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
extension ProfileReservationViewController {
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

        view.backgroundColor = .white
        view.layer.cornerRadius = 12.5

        label.font = UIFont(name: "Rubik-Bold", size: 14)
        label.text = "Rezervacijos"
        label.textColor = .black
        label.textAlignment = .center

        view.addSubview(label)

        label.translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
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

        let tap = UITapGestureRecognizer(target: self, action: #selector(turnOnMeetupTopicsScreen))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tap)

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


    private func initMenuBarStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 16
        stackView.addArrangedSubview(self.reservationButton)
        stackView.addArrangedSubview(self.informationButton)
        stackView.addArrangedSubview(self.meetupTopicsButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }

    private func initTableView() -> UITableView {
        let tableView = UITableView()
        tableView.frame = self.view.frame
        tableView.backgroundColor = UIColor.clear
        tableView.delegate = self as UITableViewDelegate
        tableView.dataSource = self as UITableViewDataSource
        tableView.separatorColor = UIColor.clear
        tableView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tableView.frame = CGRect(x: 0, y: 0, width: 382, height: 382)
        return tableView
    }

    private func intiTableViewScrollView() -> UIScrollView {
        let scrollView = UIScrollView()

        scrollView.addSubview(self.tableView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        self.tableView.register(ProfileReservationCustomTableViewCell.self, forCellReuseIdentifier: "Cell")

        self.userArr.append(UserModal(userImage: #imageLiteral(resourceName: "profileImage6"), name: "Daniel", meetupPurpose: "Pokalbiai apie viską.", address: "Saltoniškių g. 9, Vilnius", dateAndTime: "2020-03-25 d. 8:00 val."))
        self.userArr.append(UserModal(userImage: #imageLiteral(resourceName: "restaurant"), name: " ", meetupPurpose: " ", address: "Saltoniškių g. 9, Vilnius", dateAndTime: "2020-03-25 d. 8:00 val."))
        self.userArr.append(UserModal(userImage: #imageLiteral(resourceName: "profileImage2"), name: "Dovydas", meetupPurpose: " ", address: "Saltoniškių g. 9, Vilnius", dateAndTime: "2020-03-25 d. 8:00 val."))
        self.userArr.append(UserModal(userImage: #imageLiteral(resourceName: "profileImage5"), name: "Lukas", meetupPurpose: "Pokalbiai apie viską.", address: "Saltoniškių g. 9, Vilnius", dateAndTime: "2020-03-25 d. 8:00 val."))
        self.userArr.append(UserModal(userImage: #imageLiteral(resourceName: "profileImage2"), name: "Dovilė", meetupPurpose: " ", address: "Saltoniškių g. 9, Vilnius", dateAndTime: "2020-03-25 d. 8:00 val."))
        self.userArr.append(UserModal(userImage: #imageLiteral(resourceName: "profileImage4"), name: "Aušrinė", meetupPurpose: "Pokalbiai apie viską.", address: "Saltoniškių g. 9, Vilnius", dateAndTime: "2020-03-25 d. 8:00 val."))
        return scrollView
    }

}

//MARK: Constraints extension
extension ProfileReservationViewController {
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

    private func setTableViewScrollViewConstraints() {
        NSLayoutConstraint.activate([
            self.tableViewScrollView.topAnchor.constraint(equalTo: self.menuBarView.bottomAnchor, constant: 64),
            self.tableViewScrollView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.tableViewScrollView.heightAnchor.constraint(equalToConstant: 382),
            self.tableViewScrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.tableViewScrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            ])
    }
}

