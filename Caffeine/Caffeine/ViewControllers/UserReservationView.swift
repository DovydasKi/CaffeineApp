//
//  UserReservationView.swift
//  Caffeine
//
//  Created by Daniel Dluzhnevsky on 2020-03-31.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation
import UIKit

class UserReservationView: UIView {
    lazy var mainView: UIView = self.initMainView()
    lazy var tableViewScrollView: UIScrollView = self.intiTableViewScrollView()
    lazy var tableView: UITableView = self.initTableView()
    private lazy var userArr = [UserModal]()
    private var didSetupConstraints = false


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

        self.configureMainView()
        self.configureTableScrollView()
        self.configureTablewView()
        //self.setNeedsUpdateConstraints()
    }
}

//MARK: UI configuratrion
extension UserReservationView {
    private func configureMainView() {
        self.addSubview(self.mainView)
        self.setMainViewConstraintes()
    }

    private func configureTableScrollView() {
        self.mainView.addSubview(self.tableViewScrollView)
        self.tableViewScrollView.showsVerticalScrollIndicator = false
        self.setTableViewScrollViewConstraints()
    }

    private func configureTablewView() {
        self.tableView.showsVerticalScrollIndicator = true
        self.tableView.flashScrollIndicators()
        self.setTableViewConstraints()
    }
}

//MARK: UITableView extension
extension UserReservationView: UITableViewDelegate, UITableViewDataSource {
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

//MARK: UI elements extension
extension UserReservationView {
    private func initMainView() -> UIView {
        let view = UIView()
        view.backgroundColor = .orange

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }

    private func initTableView() -> UITableView {
        let tableView = UITableView()
        tableView.frame = self.frame
        tableView.backgroundColor = UIColor.clear
        tableView.delegate = self as UITableViewDelegate
        tableView.dataSource = self as UITableViewDataSource
        tableView.separatorColor = UIColor.clear
        tableView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }

    private func intiTableViewScrollView() -> UIScrollView {
        let scrollView = UIScrollView()

        scrollView.addSubview(self.tableView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        self.tableView.register(ProfileReservationCustomTableViewCell.self, forCellReuseIdentifier: "Cell")

        self.userArr.append(UserModal(userImage: #imageLiteral(resourceName: "profileImage6"), name: "Daniel", meetupPurpose: "Pokalbiai apie viską", address: "Saltoniškių g. 9, Vilnius", dateAndTime: "2020-03-25 d. 8:00 val."))
        self.userArr.append(UserModal(userImage: #imageLiteral(resourceName: "restaurant"), name: " ", meetupPurpose: " ", address: "Saltoniškių g. 9, Vilnius", dateAndTime: "2020-03-25 d. 8:00 val."))
        self.userArr.append(UserModal(userImage: #imageLiteral(resourceName: "profileImage2"), name: "Dovydas", meetupPurpose: " ", address: "Saltoniškių g. 9, Vilnius", dateAndTime: "2020-03-25 d. 8:00 val."))
        self.userArr.append(UserModal(userImage: #imageLiteral(resourceName: "profileImage5"), name: "Lukas", meetupPurpose: "Pokalbiai apie viską", address: "Saltoniškių g. 9, Vilnius", dateAndTime: "2020-03-25 d. 8:00 val."))
        self.userArr.append(UserModal(userImage: #imageLiteral(resourceName: "profileImage2"), name: "Dovilė", meetupPurpose: " ", address: "Saltoniškių g. 9, Vilnius", dateAndTime: "2020-03-25 d. 8:00 val."))
        self.userArr.append(UserModal(userImage: #imageLiteral(resourceName: "profileImage4"), name: "Aušrinė", meetupPurpose: "Pokalbiai apie viską", address: "Saltoniškių g. 9, Vilnius", dateAndTime: "2020-03-25 d. 8:00 val."))
        return scrollView
    }

}

//MARK: Constraints extension
extension UserReservationView {
    private func setMainViewConstraintes() {
        NSLayoutConstraint.activate([
            self.mainView.topAnchor.constraint(equalTo: self.topAnchor),
            self.mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.mainView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.mainView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            ])
    }

    private func setTableViewConstraints() {
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.mainView.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.mainView.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            ])
    }

    private func setTableViewScrollViewConstraints() {
        NSLayoutConstraint.activate([
            self.tableViewScrollView.topAnchor.constraint(equalTo: self.mainView.topAnchor),
            self.tableViewScrollView.bottomAnchor.constraint(equalTo: self.mainView.bottomAnchor),
            self.tableViewScrollView.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor),
            self.tableViewScrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            ])
    }
}

