//
//  ProfileReservationViewController.swift
//  Caffeine
//
//  Created by Daniel Dluzhnevsky on 2020-03-18.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation
import UIKit


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
    private lazy var reservationButton: UILabel = self.initReservationButton()
    private lazy var informationButton: UILabel = self.initInformationButton()
    private lazy var menuBarStackView: UIStackView = self.initMenuBarStackView()
    private lazy var shadowProperty = Shadow()
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

        self.view.addSubview(menuBarStackView)
        self.setMenuBarStackViewConstraints()

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
    @objc private func turnOnInformationScreen() {
        let newVC = ProfileInformationViewController()
        self.navigationController?.setViewControllers([newVC], animated: true)
        //TODO: change animation
    }
}

//MARK: UI elements extension
extension ProfileReservationViewController {
    private func initProfilePicture() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "profileImage6")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.shadowProperty.setShadow(view: imageView)
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

    private func initReservationButton() -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Bold", size: UIView.margin(of: [16, 18, 20]))
        label.text = "Rezervacijos"
        label.textColor = UIColor(named: "orangeMain")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.contentMode = .scaleAspectFit

        let bottomBorder = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        bottomBorder.backgroundColor = UIColor(named: "orangeMain")
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        label.addSubview(bottomBorder)
        bottomBorder.bottomAnchor.constraint(equalTo: label.bottomAnchor, constant: 3).isActive = true
        bottomBorder.leftAnchor.constraint(equalTo: label.leftAnchor).isActive = true
        bottomBorder.rightAnchor.constraint(equalTo: label.rightAnchor).isActive = true
        bottomBorder.heightAnchor.constraint(equalToConstant: 3).isActive = true
        return label
    }

    private func initInformationButton() -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Bold", size: UIView.margin(of: [16, 18, 20]))
        label.text = "Informacija"
        label.textColor = UIColor(named: "orangeMain")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.contentMode = .scaleAspectFit
        let tap = UITapGestureRecognizer(target: self, action: #selector(turnOnInformationScreen))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tap)
        return label
    }

    private func initMenuBarStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 128
        stackView.addArrangedSubview(self.reservationButton)
        stackView.addArrangedSubview(self.informationButton)
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
        self.title = "User List"

        self.userArr.append(UserModal(userImage: #imageLiteral(resourceName: "profileImage6"), name: "Daniel", meetupPurpose: "Pokalbiai apie viską.", address: "Saltoniškių g. 9, Vilnius", dateAndTime: "2020-03-25 d. 8:00 val."))
        self.userArr.append(UserModal(userImage: #imageLiteral(resourceName: "restaurant"), name: " ", meetupPurpose: " ", address: "Saltoniškių g. 9, Vilnius", dateAndTime: "2020-03-25 d. 8:00 val."))
        self.userArr.append(UserModal(userImage: #imageLiteral(resourceName: "profileImage3"), name: "Dovydas", meetupPurpose: " ", address: "Saltoniškių g. 9, Vilnius", dateAndTime: "2020-03-25 d. 8:00 val."))
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

    private func setMenuBarStackViewConstraints() {
        NSLayoutConstraint.activate([
            self.menuBarStackView.topAnchor.constraint(equalTo: self.fullNameLabel.bottomAnchor, constant: 32),
            self.menuBarStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            ])
    }

    private func setTableViewScrollViewConstraints() {
        NSLayoutConstraint.activate([
            self.tableViewScrollView.topAnchor.constraint(equalTo: self.menuBarStackView.bottomAnchor, constant: 64),
            self.tableViewScrollView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.tableViewScrollView.heightAnchor.constraint(equalToConstant: 382),
            self.tableViewScrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.tableViewScrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            ])
    }
}

