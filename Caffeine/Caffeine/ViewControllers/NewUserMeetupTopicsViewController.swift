//
//  NewUserMeetupTopicsViewController.swift
//  Caffeine
//
//  Created by Daniel Dluzhnevsky on 2020-03-27.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation
import UIKit

class NewUserMeetupTopicsViewController: UIViewController {
    private lazy var caffeineLogo: UIImageView = self.initCaffeineLogo()
    private lazy var topicTitle: UILabel = self.initTopicTitleLabel()
    private lazy var mainView: UIView = self.initMainView()
    private lazy var tableViewScrollView: UIScrollView = self.initTableViewScrollView()
    private lazy var tableView: UITableView = self.initTableView()
    private lazy var topicArr = [TopicModal]()
    private lazy var newTopicField: UITextField = self.initNewTopicFieldTextField()
    private lazy var addNewTopicButton: UILabel = self.initAddNewTopicButton()
    private lazy var newTopicView: UIView = self.initNewTopicView()
    private lazy var selectOrSkipButton: UIButton = self.initSelectOrSkipButton()
    //private var selectedTopics: Int?
    private var newUserMeetupPurposeModel = MeetupPurposeModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .white
        
        self.configureCaffeineLogo()
        self.configureTopicTitle()
        self.configureMainView()
        self.configureTableScrollView()
        self.configureTableView()
        self.configureNewTopicView()
        self.configureSelectOrSkipButton()
        self.configureKeyboardDynamicView()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

//MARK: UI configuratrion
extension NewUserMeetupTopicsViewController {
    private func configureCaffeineLogo() {
        self.view.addSubview(self.caffeineLogo)
        self.activateCaffeineLogoConstraints()
    }
    
    private func configureTopicTitle() {
        self.view.addSubview(self.topicTitle)
        self.activateTopicTitleConstraints()
    }
    
    private func configureMainView() {
        self.view.addSubview(self.mainView)
        self.activateMainViewConstraintes()
    }
    
    private func configureTableScrollView() {
        self.mainView.addSubview(self.tableViewScrollView)
        self.tableViewScrollView.showsVerticalScrollIndicator = false
        self.activateTableViewScrollViewConstraints()
    }
    
    private func configureTableView() {
        self.tableView.allowsMultipleSelection = true
        self.tableView.showsVerticalScrollIndicator = true
        self.tableView.flashScrollIndicators()
    }
    
    private func configureNewTopicView() {
        self.mainView.addSubview(self.newTopicView)
        self.activateNewTopicViewConstraints()
        self.configureNewTopicField()
        self.configureAddNewTopicButton()
    }
    
    private func configureNewTopicField() {
        self.newTopicView.addSubview(self.newTopicField)
        self.activateNewTopicFieldConstraints()
    }
    
    private func configureAddNewTopicButton() {
        self.newTopicView.addSubview(self.addNewTopicButton)
        self.activateAddNewTopicButtonConstraints()
    }
    
    private func configureSelectOrSkipButton() {
        self.view.addSubview(self.selectOrSkipButton)
        self.activateSelectOrSkipButtonConstraints()
    }
    
    private func configureKeyboardDynamicView() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

//MARK: UITableView extension
extension NewUserMeetupTopicsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return self.topicArr.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? MeetupTopicsWithSelectionCustomTableViewCell else { fatalError("Unable to create cell") }
        cell.meetupPurposeLabel.text = self.topicArr[indexPath.row].meetupPurpose
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 64 }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.updateCount()
        self.topicArr[indexPath.row].isSelected = true
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.updateCount()
        self.topicArr[indexPath.row].isSelected = false
    }
    
    func updateCount() {
        guard let list = tableView.indexPathsForSelectedRows as [NSIndexPath]? else {
            self.changeButtonTitle(count: nil)
            return
        }
        self.changeButtonTitle(count: list.count)
    }
}

extension NewUserMeetupTopicsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//MARK: Helper functions
extension NewUserMeetupTopicsViewController {
    private func changeButtonTitle(count: Int?) {
        guard count != nil else {
            self.selectOrSkipButton.setTitle("Praleisti", for: .normal)
            return
        }
        self.selectOrSkipButton.setTitle("Pasirinkti", for: .normal)
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
}

//MARK: Dynamic view
extension NewUserMeetupTopicsViewController {
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height - 74
            }
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
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
        self.topicArr.insert(TopicModal(meetupPurpose: newTopicText, isSelected: true), at: 0)
        
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: [IndexPath.init(row: 0, section: 0)], with: .automatic)
        self.tableView.endUpdates()
        self.tableView.selectRow(at: IndexPath.init(row: 0, section: 0), animated: false, scrollPosition: .none)
        self.updateCount()
    }
    
    @objc private func turnOnHomeScreen() {
        let homeScreenVC = HomeScreenViewController()
        guard let title = self.selectOrSkipButton.titleLabel?.text else { return }
        
        if title == "Praleisti" {
            self.navigationController?.setViewControllers([homeScreenVC], animated: true)
        }
        else {
            self.writeToJSON()
            self.navigationController?.setViewControllers([homeScreenVC], animated: true)
        }
    }
}

//MARK: UI elements extension
extension NewUserMeetupTopicsViewController {
    private func initCaffeineLogo() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "orangeBolt")
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: 120, height: 120)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
    private func initTopicTitleLabel() -> UILabel {
        let label = UILabel()
        label.text = "Pokalbio temos"
        label.font = UIFont(name: "Rubik-Black", size: 40)
        label.textColor = UIColor(named: "orangeMain")
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func initMainView() -> UIView {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12.5
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 0.5
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        tableView.widthAnchor.constraint(equalToConstant: 350).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: 318).isActive = true
        
        return tableView
    }
    
    private func initTableViewScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        
        scrollView.addSubview(self.tableView)
        
        self.tableView.register(MeetupTopicsWithSelectionCustomTableViewCell.self, forCellReuseIdentifier: "Cell")
        self.topicArr.append(TopicModal(meetupPurpose: "Pokalbiai apie abc", isSelected: false))
        self.topicArr.append(TopicModal(meetupPurpose: "Pokalbiai apie cbd", isSelected: false))
        self.topicArr.append(TopicModal(meetupPurpose: "Pokalbiai apie qwe", isSelected: false))
        self.topicArr.append(TopicModal(meetupPurpose: "Pokalbiai apie rty", isSelected: false))
        self.topicArr.append(TopicModal(meetupPurpose: "Pokalbiai apie uio", isSelected: false))
        self.topicArr.append(TopicModal(meetupPurpose: "Pokalbiai apie asd", isSelected: false))
        self.topicArr.append(TopicModal(meetupPurpose: "Pokalbiai apie vbn", isSelected: false))
        
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
        view.layer.borderColor = #colorLiteral(red: 0.09411764706, green: 0.7019607843, blue: 0.7019607843, alpha: 1)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    private func initNewTopicFieldTextField() -> UITextField {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Pokalbio tema", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
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
        label.textColor = #colorLiteral(red: 0.09411764706, green: 0.7019607843, blue: 0.7019607843, alpha: 1)
        label.textAlignment = .center
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(addNewTopic))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tap)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func initSelectOrSkipButton() -> UIButton {
        let button: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 304, height: 42))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 34.5
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.5
        button.backgroundColor = UIColor(named: "orangeMain")
        button.setTitle("Praleisti", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Rubik-Bold", size: UIView.margin(of: [20, 22, 24]))
        button.addTarget(self, action: #selector(self.turnOnHomeScreen), for: .touchUpInside)
        return button
    }
}

//MARK: Constraints
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
    
    private func activateMainViewConstraintes() {
        NSLayoutConstraint.activate([
            self.mainView.topAnchor.constraint(equalTo: self.topicTitle.bottomAnchor, constant: 32),
            self.mainView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.mainView.heightAnchor.constraint(equalToConstant: 411),
            self.mainView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.mainView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)
        ])
    }
    
    private func activateTableViewScrollViewConstraints() {
        NSLayoutConstraint.activate([
            self.tableViewScrollView.topAnchor.constraint(equalTo: self.mainView.topAnchor, constant: 16),
            self.tableViewScrollView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.tableViewScrollView.heightAnchor.constraint(equalToConstant: 318),
            self.tableViewScrollView.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor, constant: 16),
            self.tableViewScrollView.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor, constant: -16)
        ])
    }
    
    private func activateNewTopicViewConstraints () {
        NSLayoutConstraint.activate([
            self.newTopicView.topAnchor.constraint(equalTo: self.tableViewScrollView.bottomAnchor, constant: 16),
            self.newTopicView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.newTopicView.heightAnchor.constraint(equalToConstant: 45),
            self.newTopicView.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor, constant: 32),
            self.newTopicView.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor, constant: -32)
        ])
    }
    
    private func activateNewTopicFieldConstraints () {
        NSLayoutConstraint.activate([
            self.newTopicField.centerYAnchor.constraint(equalTo: self.newTopicView.centerYAnchor),
            self.newTopicField.leadingAnchor.constraint(equalTo: self.newTopicView.leadingAnchor, constant: 12),
            self.newTopicField.trailingAnchor.constraint(equalTo: self.newTopicView.trailingAnchor, constant: -135)
        ])
    }
    
    private func activateAddNewTopicButtonConstraints () {
        NSLayoutConstraint.activate([
            self.addNewTopicButton.centerYAnchor.constraint(equalTo: self.newTopicView.centerYAnchor),
            self.addNewTopicButton.trailingAnchor.constraint(equalTo: self.newTopicView.trailingAnchor, constant: -21)
        ])
    }
    
    private func activateSelectOrSkipButtonConstraints () {
        NSLayoutConstraint.activate([
            self.selectOrSkipButton.topAnchor.constraint(equalTo: self.mainView.bottomAnchor, constant: 64),
            self.selectOrSkipButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.selectOrSkipButton.widthAnchor.constraint(equalToConstant: 254),
            self.selectOrSkipButton.heightAnchor.constraint(equalToConstant: 69)
        ])
    }
}
