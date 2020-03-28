//
//  NewUserMeetupTopicsCustomTableViewCell.swift
//  Caffeine
//
//  Created by Daniel Dluzhnevsky on 2020-03-27.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation
import UIKit

class NewUserMeetupTopicsCustomTableViewCell: UITableViewCell {
    lazy var backView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 0.5
        return view
    }()

    lazy var meetupPurposeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "Rubik-Regular", size: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func layoutSubviews() {
        contentView.backgroundColor = UIColor.clear
        backgroundColor = UIColor.clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: true)
        self.addSubview(self.backView)
        self.setBackViewConstraints()

        self.backView.addSubview(self.meetupPurposeLabel)
        self.setMeetupPurposeLabelConstraints()

        if selected {
            self.setSelectedColor()
        }
        else {
            self.setNotSelectedColor()
        }
    }
    func didSelect(indexPath: NSIndexPath) {
        print("I was here didselect")
        print(indexPath.row)
    }
}

extension NewUserMeetupTopicsCustomTableViewCell {
    private func setSelectedColor() {
        self.backView.layer.cornerRadius = 12
        self.backView.clipsToBounds = true
        self.backView.layer.borderWidth = 4
        self.backView.layer.borderColor = #colorLiteral(red: 0.09411764706, green: 0.7019607843, blue: 0.7019607843, alpha: 1)
    }
    private func setNotSelectedColor() {
        self.backView.layer.cornerRadius = 12
        self.backView.clipsToBounds = true
        self.backView.layer.borderWidth = 4
        self.backView.layer.borderColor = #colorLiteral(red: 0.8980392157, green: 0.2980392157, blue: 0.0862745098, alpha: 1)
    }
}


extension NewUserMeetupTopicsCustomTableViewCell {
    private func setBackViewConstraints() {
        NSLayoutConstraint.activate([
            self.backView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            self.backView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            self.backView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            self.backView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
            ])
    }

    private func setMeetupPurposeLabelConstraints() {
        NSLayoutConstraint.activate([
            self.meetupPurposeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.meetupPurposeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
    }
}
