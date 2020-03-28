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
    private lazy var tableViewScrollView: UIScrollView = self.initTableViewScrollView()
    private lazy var tableView: UITableView = self.initTableView()
    private lazy var topicArr = [TopicModal]()
    private lazy var newTopicField: UITextField = self.initNewTopicFieldTextField()
    private lazy var addNewTopicButton: UILabel = self.initAddNewTopicButton()
    private lazy var newTopicView: UIView = self.initNewTopicView()
    private var newUserMeetupPurposeModel = NewUserMeetupPurposeModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .white
        
        self.view.addSubview(self.caffeineLogo)
        self.setCaffeineLogoConstraints()
        
        self.view.addSubview(self.topicTitle)
        self.setTopicTitleConstraints()
        
        self.view.addSubview(self.tableViewScrollView)
        self.tableViewScrollView.showsVerticalScrollIndicator = false
        self.setTableViewScrollViewConstraints()
        self.tableView.allowsMultipleSelection = true
        self.tableView.showsVerticalScrollIndicator = true
        self.tableView.flashScrollIndicators()
        
        
        self.view.addSubview(self.newTopicView)
        self.setNewTopicViewConstraints()
        self.newTopicView.addSubview(self.newTopicField)
        self.setNewTopicFieldConstraints()
        self.newTopicView.addSubview(self.addNewTopicButton)
        self.setAddNewTopicButtonConstraints()
        
    }
}


extension NewUserMeetupTopicsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.topicArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? NewUserMeetupTopicsCustomTableViewCell else { fatalError("Unable to create cell") }
        cell.meetupPurposeLabel.text = self.topicArr[indexPath.row].meetupPurpose
        cell.selectionStyle = .none
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // note that indexPath.section is used rather than indexPath.row
        print("You tapped cell number \(indexPath.row).")
        self.updateCount()
        
        //        if let cell = tableView.cellForRow(at: indexPath) as? NewUserMeetupTopicsCustomTableViewCell {
        //            cell.didSelect(indexPath: indexPath as NSIndexPath)
        //        }
        
    }
    
    func updateCount(){
        if let list = tableView.indexPathsForSelectedRows as? [NSIndexPath] {
            print(list.count)
        }
    }
}

//MARK: Button actions
extension NewUserMeetupTopicsViewController {
    @objc private func addNewTopic() {
        guard let newTopicText = self.newTopicField.text, !newTopicText.isEmpty else { return }

        if self.newUserMeetupPurposeModel.checkIfAlreadyExists(topicArr: self.topicArr, text: newTopicText) {
            self.newUserMeetupPurposeModel.shakeIfInvalid(view: self.newTopicView)
            return
        }
        self.topicArr.insert(TopicModal(meetupPurpose: newTopicText), at: 0)
        
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: [IndexPath.init(row: 0, section: 0)], with: .automatic)
        self.tableView.endUpdates()
        self.tableView.selectRow(at: IndexPath.init(row: 0, section: 0), animated: false, scrollPosition: .none)
        self.updateCount()
    }
}


//MARK: UI elements extension
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
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.widthAnchor.constraint(equalToConstant: 382).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: 318).isActive = true
        
        return tableView
    }
    
    private func initTableViewScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        
        scrollView.addSubview(self.tableView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        self.tableView.register(NewUserMeetupTopicsCustomTableViewCell.self, forCellReuseIdentifier: "Cell")
        self.topicArr.append(TopicModal(meetupPurpose: "Pokalbiai apie abc"))
        self.topicArr.append(TopicModal(meetupPurpose: "Pokalbiai apie cbd"))
        self.topicArr.append(TopicModal(meetupPurpose: "Pokalbiai apie qwe"))
        self.topicArr.append(TopicModal(meetupPurpose: "Pokalbiai apie rty"))
        self.topicArr.append(TopicModal(meetupPurpose: "Pokalbiai apie uio"))
        self.topicArr.append(TopicModal(meetupPurpose: "Pokalbiai apie asd"))
        self.topicArr.append(TopicModal(meetupPurpose: "Pokalbiai apie vbn"))
        
        
        return scrollView
    }
    
    private func initNewTopicView () -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.layer.borderWidth = 5
        view.layer.borderColor = #colorLiteral(red: 0.09411764706, green: 0.7019607843, blue: 0.7019607843, alpha: 1)
        return view
    }
    
    private func initNewTopicFieldTextField() -> UITextField{
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Pokalbio tema",attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        textField.textColor = .black
        textField.textAlignment = .left
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.init(name: "Rubik-Medium", size: 18)
        return textField
    }
    
    private func initAddNewTopicButton() -> UILabel{
        let label = UILabel()
        label.text = "Pridėti"
        label.font = UIFont(name: "Rubik-Medium", size: 18)
        label.textColor = #colorLiteral(red: 0.09411764706, green: 0.7019607843, blue: 0.7019607843, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(addNewTopic))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tap)
        return label
    }
    
}

//MARK: Constraints
extension NewUserMeetupTopicsViewController {
    private func setCaffeineLogoConstraints() {
        NSLayoutConstraint.activate([
            self.caffeineLogo.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.caffeineLogo.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.caffeineLogo.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: UIView.margin(of: [42.0, 63.0, 84.0])),
            self.caffeineLogo.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -UIView.margin(of: [42.0, 63.0, 84.0])),
            self.caffeineLogo.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: UIView.margin(of: [146.5, 146.5, 146.5]))
        ])
    }
    
    private func setTopicTitleConstraints() {
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
            self.tableViewScrollView.heightAnchor.constraint(equalToConstant: 318),
            self.tableViewScrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.tableViewScrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
        ])
    }
    
    private func setNewTopicViewConstraints (){
        NSLayoutConstraint.activate([
            self.newTopicView.topAnchor.constraint(equalTo: self.tableViewScrollView.bottomAnchor, constant: 32),
            self.newTopicView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.newTopicView.heightAnchor.constraint(equalToConstant: 45),
            self.newTopicView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40),
            self.newTopicView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40),
            
        ])
    }
    
    private func setNewTopicFieldConstraints (){
        NSLayoutConstraint.activate([
            //self.newTopicField.topAnchor.constraint(equalTo: self.newTopicBackView.topAnchor, constant: 5),
            self.newTopicField.centerYAnchor.constraint(equalTo: self.newTopicView.centerYAnchor),
            self.newTopicField.leadingAnchor.constraint(equalTo: self.newTopicView.leadingAnchor, constant: 12),
            self.newTopicField.trailingAnchor.constraint(equalTo: self.newTopicView.trailingAnchor, constant: -135),
            //self.newTopicField.bottomAnchor.constraint(equalTo: self.newTopicBackView.bottomAnchor, constant: -5),
            
        ])
    }
    
    private func setAddNewTopicButtonConstraints (){
        NSLayoutConstraint.activate([
            //self.newTopicField.topAnchor.constraint(equalTo: self.newTopicBackView.topAnchor, constant: 5),
            self.addNewTopicButton.centerYAnchor.constraint(equalTo: self.newTopicView.centerYAnchor),
            //self.addNewTopicButton.leadingAnchor.constraint(equalTo: self.newTopicView.leadingAnchor, constant: 12),
            self.addNewTopicButton.trailingAnchor.constraint(equalTo: self.newTopicView.trailingAnchor, constant: -21),
            //self.newTopicField.bottomAnchor.constraint(equalTo: self.newTopicBackView.bottomAnchor, constant: -5),
            
        ])
    }
}
