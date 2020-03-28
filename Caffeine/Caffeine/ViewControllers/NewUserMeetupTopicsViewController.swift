//
//  NewUserMeetupTopicsViewController.swift
//  Caffeine
//
//  Created by Daniel Dluzhnevsky on 2020-03-27.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation
import UIKit

class TopicModal {
    var meetupPurpose: String?
    
    init(meetupPurpose: String) {
        self.meetupPurpose = meetupPurpose
    }
}

class NewUserMeetupTopicsViewController: UIViewController{
    private lazy var caffeineLogo: UIImageView = self.initCaffeineLogo()
    private lazy var topicTitle: UILabel = self.initTopicTitleLabel()
    private lazy var tableViewScrollView: UIScrollView = self.intiTableViewScrollView()
    private lazy var tableView: UITableView = self.initTableView()
    private lazy var topicArr = [TopicModal]()
    var customCellProperty = NewUserMeetupTopicsCustomTableViewCell()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .white
        
        self.view.addSubview(self.caffeineLogo)
        self.activateCaffeineLogoConstraints()
        
        self.view.addSubview(self.topicTitle)
        self.activateTopicTitleConstraints()
        
        self.view.addSubview(self.tableViewScrollView)
        self.tableViewScrollView.showsVerticalScrollIndicator = false
        self.setTableViewScrollViewConstraints()
        self.tableView.allowsMultipleSelection = true

    }
}

extension NewUserMeetupTopicsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.topicArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? NewUserMeetupTopicsCustomTableViewCell else { fatalError("Unable to create cell") }
        cell.meetupPurposeLabel.text = self.topicArr[indexPath.row].meetupPurpose
        return cell
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // note that indexPath.section is used rather than indexPath.row
        print("You tapped cell number \(indexPath.row).")

//        if let cell = tableView.cellForRow(at: indexPath) as? NewUserMeetupTopicsCustomTableViewCell {
//            cell.didSelect(indexPath: indexPath as NSIndexPath)
//        }
    
    }
    
}
extension NewUserMeetupTopicsViewController {
    private func initCaffeineLogo() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "orangeBolt")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: 120, height: 120)
        return imageView
    }

    private func initTopicTitleLabel() -> UILabel {
        let label = UILabel()
        label.text = "Pokalbio temos"
        label.font = UIFont(name: "Rubik-Black", size: 40)
        label.textColor = UIColor(named: "orangeMain")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
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

        self.tableView.register(NewUserMeetupTopicsCustomTableViewCell.self, forCellReuseIdentifier: "Cell")
        self.topicArr.append(TopicModal(meetupPurpose: "test 1234"))
        self.topicArr.append(TopicModal(meetupPurpose: "test 1234"))
        self.topicArr.append(TopicModal(meetupPurpose: "test 1234"))
        self.topicArr.append(TopicModal(meetupPurpose: "test 1234"))
        self.topicArr.append(TopicModal(meetupPurpose: "test 1234"))
        self.topicArr.append(TopicModal(meetupPurpose: "test 1234"))
        self.topicArr.append(TopicModal(meetupPurpose: "test 1234"))
        self.topicArr.append(TopicModal(meetupPurpose: "test 1234"))
        self.topicArr.append(TopicModal(meetupPurpose: "test 1234"))
        self.topicArr.append(TopicModal(meetupPurpose: "test 1234"))
        
        return scrollView
    }
}

extension NewUserMeetupTopicsViewController {
    private func activateCaffeineLogoConstraints() {
        NSLayoutConstraint.activate([
            self.caffeineLogo.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.caffeineLogo.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.caffeineLogo.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: UIView.margin(of: [42.0, 63.0, 84.0])),
            self.caffeineLogo.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -UIView.margin(of: [42.0, 63.0, 84.0])),
           self.caffeineLogo.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: UIView.margin(of: [146.5, 146.5, 146.5]))
        ])
    }

    private func activateTopicTitleConstraints() {
        NSLayoutConstraint.activate([
            self.topicTitle.topAnchor.constraint(equalTo: self.caffeineLogo.bottomAnchor, constant: UIView.margin(of: [5, 10, 20])),
            self.topicTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.topicTitle.heightAnchor.constraint(equalToConstant: UIView.margin(of: [47, 47, 47])),
            self.topicTitle.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)
        ])
    }
    
    private func setTableViewScrollViewConstraints() {
        NSLayoutConstraint.activate([
            self.tableViewScrollView.topAnchor.constraint(equalTo: self.topicTitle.bottomAnchor, constant: 64),
            self.tableViewScrollView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.tableViewScrollView.heightAnchor.constraint(equalToConstant: 382),
            self.tableViewScrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.tableViewScrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            ])
    }
}
