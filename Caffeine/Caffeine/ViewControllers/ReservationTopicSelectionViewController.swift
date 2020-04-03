//
//  ReservationTopicSelectionViewController.swift
//  Caffeine
//
//  Created by Daniel Dluzhnevsky on 2020-04-03.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation
import UIKit

class ReservationTopicSelectionViewController: UIViewController {
    private lazy var arrowBackIcon: UIImageView = self.initArrowBackView()
    private lazy var titleLabel: UILabel = self.initTitleLabel()
    private var meetupTopicsView = MeetupTopicsView(frame: .zero, multiple: true)
    private lazy var continueButton: UIButton = self.initSaveButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .white

        self.configureArrowBackView()
        self.configureTitleLabel()
        self.configureMeetupTopicsView()
        self.configureContinueButton()

    }
}

//MARK: UI configuratrion
extension ReservationTopicSelectionViewController {
    private func configureArrowBackView() {
        self.view.addSubview(self.arrowBackIcon)
        self.activateArrowBackViewConstraints()
    }

    private func configureTitleLabel() {
        self.view.addSubview(self.titleLabel)
        self.activateTitleLabelConstraints()
    }

    private func configureMeetupTopicsView() {
        self.meetupTopicsView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.meetupTopicsView)
        self.activateMeetupTopicsViewConstraints()
    }

    private func configureContinueButton() {
        self.view.addSubview(self.continueButton)
        self.activateContinueButtonConstraints()
    }
}

//MARK: Button actions
extension ReservationTopicSelectionViewController {
    @objc private func turnOnNextPage() {
        //TODO: next page
    }

    @objc func backToPreviousScreen() {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: UI elements extension
extension ReservationTopicSelectionViewController {
    private func initArrowBackView() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "arrowBack").withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor(named: "orangeMain")
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        imageView.gestureRecognizers = [UITapGestureRecognizer(target: self, action: #selector(backToPreviousScreen))]
        return imageView
    }

    private func initCaffeineLogo() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "orangeBolt")
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }

    private func initTitleLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Pasirinkite pokalbio temą"
        label.textColor = UIColor(named: "orangeMain")
        label.font = UIFont(name: "Rubik-Black", size: 25.0)
        label.numberOfLines = 3
        label.textAlignment = .center
        return label
    }

    private func initSaveButton() -> UIButton {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 34.5
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.5
        button.backgroundColor = UIColor(named: "orangeMain")
        button.setTitle("Toliau", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Rubik-Bold", size: UIView.margin(of: [24, 28, 32]))
        button.addTarget(self, action: #selector(self.turnOnNextPage), for: .touchUpInside)
        return button
    }
}

//MARK: Constraints extension
extension ReservationTopicSelectionViewController {
    private func activateArrowBackViewConstraints() {
        NSLayoutConstraint.activate([
            self.arrowBackIcon.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16),
            self.arrowBackIcon.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32.0),
            self.arrowBackIcon.heightAnchor.constraint(equalToConstant: 32)
            ])
    }

    private func activateTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 32),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 65.0),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -65.0),
            self.titleLabel.heightAnchor.constraint(equalToConstant: 82.0)
            ])
    }

    private func activateMeetupTopicsViewConstraints() {
        NSLayoutConstraint.activate([

            self.meetupTopicsView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 32),
            self.meetupTopicsView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.meetupTopicsView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.meetupTopicsView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
            ])
    }

    private func activateContinueButtonConstraints() {
        NSLayoutConstraint.activate([
            self.continueButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 79.5),
            self.continueButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -79.5),
            self.continueButton.heightAnchor.constraint(equalToConstant: 69),
            self.continueButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -100.0)
            ])

    }
}
