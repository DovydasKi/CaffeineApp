//
//  ProfileReservationCustomTableViewCell.swift
//  Caffeine
//
//  Created by Daniel Dluzhnevsky on 2020-03-19.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation
import UIKit

class ProfileReservationCustomTableViewCell: UITableViewCell {
    private lazy var shadowProperty = Shadow()
    lazy var backView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        self.shadowProperty.setShadow(view: view)
        return view
    }()

    lazy var userImage: UIImageView = {
        let userImage = UIImageView()
        userImage.contentMode = .scaleAspectFill
        userImage.translatesAutoresizingMaskIntoConstraints = false
        return userImage
    }()

    lazy var namelabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "Rubik-Medium", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var meetupPurposeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var dateAndTimeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()



    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews() {
        contentView.backgroundColor = UIColor.clear
        backgroundColor = UIColor.clear
        self.backView.layer.cornerRadius = 12
        self.backView.clipsToBounds = true
        self.backView.layer.borderWidth = 4
        self.backView.layer.borderColor = #colorLiteral(red: 0.8980392157, green: 0.2980392157, blue: 0.0862745098, alpha: 1)
        self.userImage.layer.cornerRadius = 32
        self.userImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        self.addSubview(self.backView)
        self.setBackViewConstraints()

        self.backView.addSubview(self.userImage)
        self.setUserImageConstraints()

        self.backView.addSubview(self.namelabel)
        self.setNamelabelConstraints()

        self.backView.addSubview(self.meetupPurposeLabel)
        self.setMeetupPurposeLabelConstraints()

        self.backView.addSubview(self.addressLabel)
        self.setAddressLabelConstraints()

        self.backView.addSubview(self.dateAndTimeLabel)
        self.setDateAndTimeLabelConstraints()
    }
}

extension ProfileReservationCustomTableViewCell {
    private func setBackViewConstraints() {
        NSLayoutConstraint.activate([
            self.backView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            self.backView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.backView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            ])
    }

    private func setUserImageConstraints() {
        NSLayoutConstraint.activate([
            self.userImage.topAnchor.constraint(equalTo: self.backView.topAnchor, constant: 22),
            self.userImage.centerYAnchor.constraint(equalTo: self.backView.centerYAnchor),
            self.userImage.heightAnchor.constraint(equalToConstant: 70),
            self.userImage.widthAnchor.constraint(equalToConstant: 70),
            self.userImage.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 22)
            ])
    }

    private func setNamelabelConstraints() {
        NSLayoutConstraint.activate([
            self.namelabel.topAnchor.constraint(equalTo: self.backView.topAnchor, constant: 22),
            self.namelabel.leadingAnchor.constraint(equalTo: self.userImage.trailingAnchor, constant: 16)
            ])
    }

    private func setMeetupPurposeLabelConstraints() {
        NSLayoutConstraint.activate([
            self.meetupPurposeLabel.topAnchor.constraint(equalTo: self.backView.topAnchor, constant: 25),
            self.meetupPurposeLabel.leadingAnchor.constraint(equalTo: self.namelabel.trailingAnchor, constant: 24)
            ])
    }

    private func setAddressLabelConstraints() {
        NSLayoutConstraint.activate([
            self.addressLabel.leadingAnchor.constraint(equalTo: self.userImage.trailingAnchor, constant: 16),
            self.addressLabel.topAnchor.constraint(equalTo: self.namelabel.bottomAnchor, constant: 4)
            ])
    }

    private func setDateAndTimeLabelConstraints() {
        NSLayoutConstraint.activate([
            self.dateAndTimeLabel.leadingAnchor.constraint(equalTo: self.userImage.trailingAnchor, constant: 16),
            self.dateAndTimeLabel.topAnchor.constraint(equalTo: self.addressLabel.bottomAnchor, constant: 4)
            ])
    }
}
