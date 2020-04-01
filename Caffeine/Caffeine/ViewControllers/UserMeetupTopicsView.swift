//
//  UserMeetupTopicsView.swift
//  Caffeine
//
//  Created by Daniel Dluzhnevsky on 2020-04-01.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation
import UIKit

class UserMeetupTopicsView: UIView {
    lazy var mainView: UIView = self.initMainView()
    lazy var tableViewScrollView: UIScrollView = self.initTableViewScrollView()
    lazy var tableView: UITableView = self.initTableView()
    lazy var newTopicView: UIView = self.initNewTopicView()
    lazy var newTopicField: UITextField = self.initNewTopicFieldTextField()
    lazy var addNewTopicButton: UILabel = self.initAddNewTopicButton()
    lazy var topicsAmount: UILabel = self.initTopicsAmountLabel()
    
    private lazy var topicArr = [TopicModal]()
    private var userMeetupPurposeModel = MeetupPurposeModel()
    
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
        self.configureNewTopicView()
        self.configureTopicsAmountLabel()
        self.configureKeyboardDynamicView()
    }
}

//MARK: UI configuratrion
extension UserMeetupTopicsView {
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
        self.tableView.allowsMultipleSelection = true
        self.tableView.showsVerticalScrollIndicator = true
        self.tableView.flashScrollIndicators()
        self.setTableViewConstraints()
    }
    
    private func configureNewTopicView() {
        self.mainView.addSubview(self.newTopicView)
        self.setNewTopicViewConstraints()
        self.configureNewTopicField()
        self.configureAddNewTopicButton()
    }
    
    private func configureNewTopicField() {
        self.newTopicView.addSubview(self.newTopicField)
        self.setNewTopicFieldConstraints()
    }
    
    private func configureAddNewTopicButton() {
        self.newTopicView.addSubview(self.addNewTopicButton)
        self.setAddNewTopicButtonConstraints()
    }
    
    private func configureTopicsAmountLabel() {
        self.addSubview(self.topicsAmount)
        self.setTopicsAmountLabelConstraints()
        self.updateTopicsAmount()
    }

    private func configureKeyboardDynamicView() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

//MARK: UITableView extension
extension UserMeetupTopicsView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return self.topicArr.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? MeetupTopicsCustomTableViewCell else { fatalError("Unable to create cell") }
        cell.meetupPurposeLabel.text = self.topicArr[indexPath.row].meetupPurpose
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 64 }
    
}

extension UserMeetupTopicsView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//MARK: Helper functions
extension UserMeetupTopicsView {
    private func updateTopicsAmount() {
        if self.topicArr.count == 0 {
            self.topicsAmount.text = "Iš viso: \(String(describing: 0))"
        }
        self.topicsAmount.text = "Iš viso: \(String(describing: self.topicArr.count))"
    }
    
    private func writeToJSON() {
        do {
            let fileURL = try FileManager.default
                .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent("example.json")
            
            try JSONEncoder().encode(self.topicArr)
                .write(to: fileURL)
        } catch {
            print(error)
        }
    }
    
    private func readFromJSON() {
        do {
            let fileURL = try FileManager.default
                .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                .appendingPathComponent("example.json")

            let data = try Data(contentsOf: fileURL)
            let topics = try JSONDecoder().decode([TopicModal].self, from: data)
            for topic in topics {
                if topic.isSelected == true {
                    self.topicArr.append(topic)
                }
            }
        } catch {
            print(error)
        }
    }
}

//MARK: Dynamic view
extension UserMeetupTopicsView {
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.frame.origin.y == 0 {
                self.frame.origin.y -= keyboardSize.height - 94
            }
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.frame.origin.y != 0 {
            self.frame.origin.y = 0
        }
    }
}

//MARK: Button actions
extension UserMeetupTopicsView {
    @objc private func addNewTopic() {
        guard let newTopicText = self.newTopicField.text, !newTopicText.isEmpty else { return }
        
        if self.userMeetupPurposeModel.checkIfAlreadyExists(topicArr: self.topicArr, text: newTopicText) {
            self.userMeetupPurposeModel.shakeIfInvalid(view: self.newTopicView)
            return
        }
        self.topicArr.insert(TopicModal(meetupPurpose: newTopicText, isSelected: true), at: 0)
        
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: [IndexPath.init(row: 0, section: 0)], with: .automatic)
        self.tableView.endUpdates()
        self.tableView.selectRow(at: IndexPath.init(row: 0, section: 0), animated: false, scrollPosition: .none)
        self.newTopicField.text?.removeAll()
        self.writeToJSON()
        self.updateTopicsAmount()
    }
}


//MARK: UI elements extension
extension UserMeetupTopicsView {
    private func initMainView() -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
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
    
    private func initTableViewScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        
        scrollView.addSubview(self.tableView)
        
        self.tableView.register(MeetupTopicsCustomTableViewCell.self, forCellReuseIdentifier: "Cell")
        self.readFromJSON()
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }
    
    private func initNewTopicView () -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 0.5
        view.layer.borderWidth = 5
        view.layer.borderColor = #colorLiteral(red: 0.8980547786, green: 0.2980546653, blue: 0.08636900038, alpha: 1)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    private func initNewTopicFieldTextField() -> UITextField {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Pokalbio tema", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        textField.textColor = .black
        textField.textAlignment = .left
        textField.font = UIFont.init(name: "Rubik-Medium", size: 18)
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }
    
    private func initAddNewTopicButton() -> UILabel {
        let label = UILabel()
        label.text = "Pridėti"
        label.font = UIFont(name: "Rubik-Medium", size: 18)
        label.textColor = UIColor(named: "orangeMain")
        label.textAlignment = .center
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(addNewTopic))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tap)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func initTopicsAmountLabel() -> UILabel {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "Rubik-Medium", size: 12)
        label.textColor = UIColor(named: "orangeMain")
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

}

//MARK: Constraints extension
extension UserMeetupTopicsView {
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
    
    private func setNewTopicViewConstraints () {
        NSLayoutConstraint.activate([
            self.newTopicView.topAnchor.constraint(equalTo: self.tableViewScrollView.bottomAnchor, constant: 16),
            self.newTopicView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.newTopicView.heightAnchor.constraint(equalToConstant: 45),
            self.newTopicView.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor, constant: 32),
            self.newTopicView.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor, constant: -32)
        ])
    }
    
    private func setNewTopicFieldConstraints () {
        NSLayoutConstraint.activate([
            self.newTopicField.centerYAnchor.constraint(equalTo: self.newTopicView.centerYAnchor),
            self.newTopicField.leadingAnchor.constraint(equalTo: self.newTopicView.leadingAnchor, constant: 12),
            self.newTopicField.trailingAnchor.constraint(equalTo: self.newTopicView.trailingAnchor, constant: -135)
        ])
    }
    
    private func setAddNewTopicButtonConstraints () {
        NSLayoutConstraint.activate([
            self.addNewTopicButton.centerYAnchor.constraint(equalTo: self.newTopicView.centerYAnchor),
            self.addNewTopicButton.trailingAnchor.constraint(equalTo: self.newTopicView.trailingAnchor, constant: -21)
        ])
    }
    
    private func setTopicsAmountLabelConstraints () {
        NSLayoutConstraint.activate([
            self.topicsAmount.topAnchor.constraint(equalTo: self.newTopicView.bottomAnchor, constant: 16),
            self.topicsAmount.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
    
}

