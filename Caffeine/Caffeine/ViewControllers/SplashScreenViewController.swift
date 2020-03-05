//
//  SplashScreenViewController.swift
//  Caffeine
//
//  Created by Daniel Dluzhnevsky on 2020-03-02.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import UIKit

class SplashScreenViewController: UIViewController {

    private lazy var caffeineLabel: UILabel = self.initCaffeineLabel("Caffeine")
    private lazy var caffeineLogo: UIImageView = self.initCaffeineLogo()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "orangeMain")
        navigationController?.navigationBar.isHidden = true

        self.view.addSubview(self.caffeineLogo)
        self.setBoltImageConstraints(self.caffeineLogo)

        self.view.addSubview(self.caffeineLabel)
        self.setCaffeineLabelConstraints(self.caffeineLabel)

        let viewController = MainScreenViewController()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.navigationController?.setViewControllers([viewController], animated: true)
        }
    }
}

//MARK: UI elements extension
extension SplashScreenViewController {
    private func initCaffeineLabel(_ title: String) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = UIFont(name: "Rubik-Bold", size: 68)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }

    private func initCaffeineLogo() -> UIImageView {
        let image = UIImage(named: "bolt.png")
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: 0, y: 0, width: 120, height: 120)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit

        return imageView
    }
}

//MARK: Constraints extension
extension SplashScreenViewController {

    private func setCaffeineLabelConstraints(_ caffeineLabel: UILabel) {
        let margineGuide = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            caffeineLabel.topAnchor.constraint(equalTo: margineGuide.topAnchor, constant: 480),
            caffeineLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            caffeineLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            caffeineLabel.heightAnchor.constraint(equalToConstant: 80),
            caffeineLabel.trailingAnchor.constraint(equalTo: margineGuide.trailingAnchor)])
    }

    private func setBoltImageConstraints(_ imageView: UIImageView) {
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            imageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 58),
            imageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -500),
            imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 84),
            imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -84)])
    }
}
