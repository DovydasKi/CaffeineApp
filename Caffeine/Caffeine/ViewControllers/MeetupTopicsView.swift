//
//  UserMeetupTopicsView.swift
//  Caffeine
//
//  Created by Daniel Dluzhnevsky on 2020-04-01.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation
import UIKit

class MeetupTopicsView: UIView, UITextFieldDelegate {
    private lazy var containerView: UIView = self.initContainerView()
    private lazy var mainView: UIView = self.initMainView()
    private lazy var tableViewScrollView: UIScrollView = self.initTableViewScrollView()
    private var tableView = UITableView()
    private var meetupTopicsWithSelectionTableView: MeetupTopicsWithSelectionTableView?
    private lazy var newTopicView: UIView = self.initNewTopicView()
    private lazy var newTopicField: UITextField = self.initNewTopicFieldTextField()
    private lazy var addNewTopicButton: UILabel = self.initAddNewTopicButton()
    private lazy var topicsAmount: UILabel = self.initTopicsAmountLabel()
    private var withMultipleSelection = Bool()

    private var userMeetupPurposeModel = MeetupPurposeModel()

    init(frame: CGRect, multiple: Bool?) {
        super.init(frame: frame)
        guard let isMultiple = multiple else { return }
        self.withMultipleSelection = isMultiple
        self.setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }

    private func setupView() {
        backgroundColor = .clear
        self.configureContainerView()
        self.configureMainView()
        self.configureTableScrollView()
        self.configureTableView()
        self.configureNewTopicView()
        self.configureTopicsAmountLabel()
    }
}

//MARK: UI configuratrion
extension MeetupTopicsView {
    private func configureContainerView() {
        self.addSubview(self.containerView)
        self.activateContainerViewConstraints()
    }

    private func configureMainView() {
        self.containerView.addSubview(self.mainView)
        self.activateMainViewConstraints()
    }

    private func configureTableScrollView() {
        self.mainView.addSubview(self.tableViewScrollView)
        self.tableViewScrollView.showsVerticalScrollIndicator = false
        self.activateTableViewScrollViewConstraints()
    }

    private func configureTableView() {
        self.meetupTopicsWithSelectionTableView = MeetupTopicsWithSelectionTableView(tv: self.tableView, withMultipleSelection: self.withMultipleSelection, topicAmountLabel: self.topicsAmount)

        self.meetupTopicsWithSelectionTableView?.tableView.reloadData()

        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.activateTableViewConstraints()
    }

    private func configureNewTopicView() {
        self.containerView.addSubview(self.newTopicView)
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

    private func configureTopicsAmountLabel() {
        if !withMultipleSelection {
            self.containerView.addSubview(self.topicsAmount)
            self.activateTopicsAmountLabelConstraints()
            self.updateTopicsAmount()
        }
    }
}

//MARK: Helper functions
extension MeetupTopicsView {
    public func updateTopicsAmount() {
        guard let topicArr = self.meetupTopicsWithSelectionTableView?.getTopicArr() else { return }
        if topicArr.count == 0 {
            self.topicsAmount.text = "Iš viso: \(String(describing: 0))"
        }
        self.topicsAmount.text = "Iš viso: \(String(describing: topicArr.count))"
    }
}

//MARK: Button actions
extension MeetupTopicsView {
    @objc private func addNewTopic() {
        guard let newTopicText = self.newTopicField.text, !newTopicText.isEmpty else { return }

        guard let topicArr = self.meetupTopicsWithSelectionTableView?.getTopicArr() else { return }
        if self.userMeetupPurposeModel.checkIfAlreadyExists(topicArr: topicArr, text: newTopicText) {
            self.userMeetupPurposeModel.shakeIfInvalid(view: self.newTopicView)
            return
        }

        self.meetupTopicsWithSelectionTableView?.insertValue(meetupPurpose: newTopicText)
        self.newTopicField.text?.removeAll()
        self.updateTopicsAmount()
    }

    @objc func longPress(sender: UILongPressGestureRecognizer) {
        guard let currentVC = UIApplication.shared.keyWindow?.rootViewController else { return }
        if sender.state == UIGestureRecognizer.State.began {
            let touchPoint = sender.location(in: tableView)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                guard let topicArr = self.meetupTopicsWithSelectionTableView?.getTopicArr() else { return }
                guard let meetupPurpose = topicArr[indexPath.row].meetupPurpose else { return }
                var actions: [(String, UIAlertAction.Style)] = []
                actions.append(("Ištrinti", UIAlertAction.Style.destructive))
                actions.append(("Atšaukti", UIAlertAction.Style.cancel))
                print(indexPath.row)
                ActionSheet.showActionsheet(viewController: currentVC, title: "Pokalbio temos trynimas", message: "Ar tikrai norite ištrinti: \(meetupPurpose)", actions: actions) {
                    (index) in
                    switch index {
                    case 0:
                        self.meetupTopicsWithSelectionTableView?.deleteValue(indexPath: indexPath)
                        self.updateTopicsAmount()
                    default:
                        return
                    }
                }
            }
        }
    }
}

//MARK: UI elements extension
extension MeetupTopicsView {
    private func initContainerView() -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }

    private func initMainView() -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false

        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(self.longPress))
        self.tableView.addGestureRecognizer(longPress)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }

    private func initTableViewScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.addSubview(self.tableView)

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
extension MeetupTopicsView {
    private func activateContainerViewConstraints() {
        NSLayoutConstraint.activate([
            self.containerView.topAnchor.constraint(equalTo: self.topAnchor),
            self.containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            ])
    }

    private func activateMainViewConstraints() {
        NSLayoutConstraint.activate([
            self.mainView.topAnchor.constraint(equalTo: self.topAnchor),
            self.mainView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.mainView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.mainView.heightAnchor.constraint(equalToConstant: 318),
            ])
    }

    private func activateTableViewConstraints() {
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.mainView.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.mainView.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor, constant: 32),
            self.tableView.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor, constant: -32)
            ])
    }

    private func activateTableViewScrollViewConstraints() {
        NSLayoutConstraint.activate([
            self.tableViewScrollView.topAnchor.constraint(equalTo: self.mainView.topAnchor),
            self.tableViewScrollView.bottomAnchor.constraint(equalTo: self.mainView.bottomAnchor),
            self.tableViewScrollView.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor),
            self.tableViewScrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            ])
    }

    private func activateNewTopicViewConstraints () {
        NSLayoutConstraint.activate([
            self.newTopicView.topAnchor.constraint(equalTo: self.mainView.bottomAnchor, constant: 32),
            self.newTopicView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.newTopicView.heightAnchor.constraint(equalToConstant: 45),
            self.newTopicView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 64),
            self.newTopicView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -64)
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

    private func activateTopicsAmountLabelConstraints () {
        NSLayoutConstraint.activate([
            self.topicsAmount.topAnchor.constraint(equalTo: self.mainView.bottomAnchor, constant: 8),
            self.topicsAmount.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            ])
    }

}

