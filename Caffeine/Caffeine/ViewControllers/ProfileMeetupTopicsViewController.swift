//
//  ProfileMeetupTopicsViewController.swift
//  Caffeine
//
//  Created by Daniel Dluzhnevsky on 2020-03-29.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class ProfileMeetupTopicsViewController: UIViewController{
    private lazy var profilePicture: UIImageView = self.initProfilePicture()
    private lazy var fullNameLabel: UILabel = self.initFullNameLabel()
    private lazy var menuBarView: UIView = self.initMenuBarView()

    private lazy var reservationButton: UIView = self.initReservationButton()
    private lazy var meetupTopicsButton: UIView = self.initMeetupTopicsButton()
    private lazy var informationButton: UIView = self.initInformationButton()
    
    private lazy var mainView: UIView = self.initMainView()
    private lazy var tableViewScrollView: UIScrollView = self.initTableViewScrollView()
    private lazy var tableView: UITableView = self.initTableView()
    private lazy var newTopicView: UIView = self.initNewTopicView()
    private lazy var newTopicField: UITextField = self.initNewTopicFieldTextField()
    private lazy var addNewTopicButton: UILabel = self.initAddNewTopicButton()
    private lazy var topicsAmount: UILabel = self.initTopicsAmountLabel()
    
    private lazy var topicArr = [TopicModal]()
    private var userMeetupPurposeModel = MeetupPurposeModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .white
        
        self.configureProfilePicture()
        self.configureFullNameLabel()
        self.configureMenuBarView()
        self.configureMainView()
        self.configureTableScrollView()
        self.configureTablewView()
        self.configureNewTopicView()
        self.configureTopicsAmountLabel()
        self.configureKeyboardDynamicView()
    }
}

//MARK: UI configuratrion
extension ProfileMeetupTopicsViewController {
    private func configureProfilePicture() {
        self.view.addSubview(self.profilePicture)
        self.setProfilePictureConstraints()
    }
    
    private func configureFullNameLabel() {
        self.view.addSubview(self.fullNameLabel)
        self.setFullNameLabelConstraints()
    }
    
    private func configureMenuBarView() {
        self.view.addSubview(self.menuBarView)
        self.setMenuBarViewConstraints()
        self.configureReservationButton()
        self.configureMeetupTopicsButton()
        self.configureInformationButton()
    }
    
    private func configureReservationButton() {
        self.menuBarView.addSubview(self.reservationButton)
        self.setReservationButtonConstraints()
    }
    
    private func configureMeetupTopicsButton() {
        self.menuBarView.addSubview(self.meetupTopicsButton)
        self.setMeetupTopicsButtonConstraints()
    }
    
    private func configureInformationButton() {
        self.menuBarView.addSubview(self.informationButton)
        self.setInformationButtonConstraints()
    }
    
    private func configureMainView() {
        self.view.addSubview(self.mainView)
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
        self.view.addSubview(self.topicsAmount)
        self.setTopicsAmountLabelConstraints()
        self.updateTopicsAmount()
    }

    private func configureKeyboardDynamicView() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

//MARK: UITableView extension
extension ProfileMeetupTopicsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return self.topicArr.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ProfileMeetupTopicsCustomTableViewCell else { fatalError("Unable to create cell") }
        cell.meetupPurposeLabel.text = self.topicArr[indexPath.row].meetupPurpose
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 64 }
    
}

extension ProfileMeetupTopicsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//MARK: Helper functions
extension ProfileMeetupTopicsViewController {
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
extension ProfileMeetupTopicsViewController {
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height - 94
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
    
    private func initMainView() -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
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
        return tableView
    }
    
    private func initTableViewScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        
        scrollView.addSubview(self.tableView)
        
        self.tableView.register(ProfileMeetupTopicsCustomTableViewCell.self, forCellReuseIdentifier: "Cell")
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
    
    private func setMainViewConstraintes() {
        NSLayoutConstraint.activate([
            self.mainView.topAnchor.constraint(equalTo: self.menuBarView.bottomAnchor, constant: 32),
            self.mainView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.mainView.heightAnchor.constraint(equalToConstant: 411),
            self.mainView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32),
            self.mainView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32)
        ])
    }
    
    private func setTableViewConstraints() {
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.mainView.topAnchor, constant: 16),
            self.tableView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.tableView.heightAnchor.constraint(equalToConstant: 318),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32)
        ])
    }
    
    private func setTableViewScrollViewConstraints() {
        NSLayoutConstraint.activate([
            self.tableViewScrollView.topAnchor.constraint(equalTo: self.mainView.topAnchor, constant: 16),
            self.tableViewScrollView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.tableViewScrollView.heightAnchor.constraint(equalToConstant: 318),
            self.tableViewScrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32),
            self.tableViewScrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32)
        ])
    }
    
    private func setNewTopicViewConstraints () {
        NSLayoutConstraint.activate([
            self.newTopicView.topAnchor.constraint(equalTo: self.tableViewScrollView.bottomAnchor, constant: 16),
            self.newTopicView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
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
            self.topicsAmount.topAnchor.constraint(equalTo: self.mainView.bottomAnchor, constant: 16),
            self.topicsAmount.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ])
    }
    
    
}
