//
//  RegistrationConfirmationViewController.swift
//  Caffeine
//
//  Created by Daniel Dluzhnevsky on 2020-03-10.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation
import NVActivityIndicatorView

class RegistrationConfirmationViewController: UIViewController, NVActivityIndicatorViewable {
    private lazy var caffeineLogo: UIImageView = self.initCaffeineLogo()
    private lazy var caffeineLabel: UILabel = self.initCaffeineLabel()
    private lazy var confirmationLabel: UILabel = self.initConfirmationLabel()
    private lazy var activityIndicator: NVActivityIndicatorView = self.initActivityIndicator()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "orangeMain")
        navigationController?.navigationBar.isHidden = true

        self.view.addSubview(self.caffeineLogo)
        self.activateCaffeineLogoConstraints()

        self.view.addSubview(self.caffeineLabel)
        self.activateCaffeineLabelConstraints()

        self.view.addSubview(self.confirmationLabel)
        self.activateConfirmationLabelConstraints()

        self.view.addSubview(self.activityIndicator)
        self.activateActivityIndicatorConstraints()
        
        self.activityIndicator.startAnimating()
        
        let viewController = RegistrationImageSelectionViewController()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		UIApplication.shared.setStatusBarStyle(.default, animated: animated)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		UIApplication.shared.setStatusBarStyle(.lightContent, animated: animated)
	}
}

extension RegistrationConfirmationViewController {
    private func initCaffeineLogo() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "bolt")
        imageView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }

    private func initCaffeineLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Bold", size: 54)
        label.text = "Caffeine"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.contentMode = .scaleAspectFit
        return label
    }

    private func initConfirmationLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Bold", size: UIView.margin(of: [20, 24, 34]))
        label.text = "Patvirtinkite el.pašto adresą"
        label.numberOfLines = 2
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.contentMode = .scaleAspectFit
        return label
    }

    private func initActivityIndicator() -> NVActivityIndicatorView {
        let animationTypeLabel = UILabel(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
        let activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: 100, y: 100, width: 200, height: 200), type: .circleStrokeSpin)
        animationTypeLabel.sizeToFit()
        animationTypeLabel.textColor = UIColor.white
        animationTypeLabel.frame.origin.x += 5
        animationTypeLabel.frame.origin.y += CGFloat(200) - animationTypeLabel.frame.size.height
        animationTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.padding = 20

        return activityIndicatorView
    }
}
//MARK: Constraints extension
extension RegistrationConfirmationViewController {
    private func activateCaffeineLogoConstraints() {
        NSLayoutConstraint.activate([
            self.caffeineLogo.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: UIView.margin(of: [48.5, 72.75, 97.0])),
            self.caffeineLogo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.caffeineLogo.heightAnchor.constraint(equalToConstant: 90),
            self.caffeineLogo.widthAnchor.constraint(equalToConstant: 54)
        ])
    }

    private func activateCaffeineLabelConstraints() {
        NSLayoutConstraint.activate([
            self.caffeineLabel.topAnchor.constraint(equalTo: self.caffeineLogo.bottomAnchor, constant: UIView.margin(of: [7.5, 13.25, 26.5])),
            self.caffeineLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: UIView.margin(of: [14.5, 29.25, 58.5])),
            self.caffeineLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -UIView.margin(of: [14.5, 29.25, 58.5])),
            self.caffeineLabel.bottomAnchor.constraint(equalTo: self.caffeineLogo.bottomAnchor, constant: UIView.margin(of: [21, 55, 80.5]))
        ])
    }

    private func activateConfirmationLabelConstraints() {
        NSLayoutConstraint.activate([
            self.confirmationLabel.topAnchor.constraint(equalTo: self.caffeineLabel.bottomAnchor, constant: UIView.margin(of: [44.25, 60, 120])),
            self.confirmationLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: UIView.margin(of: [14.5, 29.25, 58.5])),
            self.confirmationLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -UIView.margin(of: [14.5, 29.25, 58.5])),
            self.confirmationLabel.bottomAnchor.constraint(equalTo: self.caffeineLabel.bottomAnchor, constant: UIView.margin(of: [57.75, 117.5, 215])) // cia
        ])
    }

    private func activateActivityIndicatorConstraints() {
        NSLayoutConstraint.activate([
            self.activityIndicator.topAnchor.constraint(equalTo: self.confirmationLabel.bottomAnchor, constant: 32),
            self.activityIndicator.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -107),
            self.activityIndicator.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 107),
            self.activityIndicator.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}
