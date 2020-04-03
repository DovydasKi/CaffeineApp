//
//  SplashScreenViewController.swift
//  Caffeine
//
//  Created by Daniel Dluzhnevsky on 2020-03-02.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import UIKit

class SplashScreenViewController: UIViewController {
    private lazy var caffeineLabel: UILabel = self.initCaffeineLabel()
    private lazy var caffeineLogo: UIImageView = self.initCaffeineLogo()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "orangeMain")
        navigationController?.navigationBar.isHidden = true

        self.view.addSubview(self.caffeineLogo)
        self.setCaffeineLogoConstraints()

        self.view.addSubview(self.caffeineLabel)
        self.setCaffeineLabelConstraints()
        
        let viewController = HomeScreenViewController()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.navigationController?.setViewControllers([viewController], animated: true)
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

//MARK: UI elements extension
extension SplashScreenViewController {
    private func initCaffeineLabel() -> UILabel {
        let label = UILabel()
        label.text = "Caffeine"
        label.font = UIFont(name: "Rubik-Bold", size: 68)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }

    private func initCaffeineLogo() -> UIImageView {
        let image = #imageLiteral(resourceName: "bolt")
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: 120, height: 120)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
}

//MARK: Constraints extension
extension SplashScreenViewController {
    private func setCaffeineLogoConstraints() {
        NSLayoutConstraint.activate([
            self.caffeineLogo.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.caffeineLogo.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: UIView.margin(of: [48.5, 72.75, 97.0])),
            self.caffeineLogo.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: UIView.margin(of: [42.0, 63.0, 84.0])),
            self.caffeineLogo.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -UIView.margin(of: [42.0, 63.0, 84.0])),
            self.caffeineLogo.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: UIView.margin(of: [177.0, 265.5, 354.0]))
        ])
    }
    
    private func setCaffeineLabelConstraints() {
        NSLayoutConstraint.activate([
            self.caffeineLabel.topAnchor.constraint(equalTo: self.caffeineLogo.bottomAnchor, constant: UIView.margin(of: [40.0, 60.0, 80.0])),
            self.caffeineLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.caffeineLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
			self.caffeineLabel.heightAnchor.constraint(equalToConstant: UIView.margin(of: [40.0, 60.0, 80.0]))
		])
    }

    
}
