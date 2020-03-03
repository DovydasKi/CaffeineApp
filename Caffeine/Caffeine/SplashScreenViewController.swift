//
//  SplashScreenViewController.swift
//  Caffeine
//
//  Created by Daniel Dluzhnevsky on 2020-03-02.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import UIKit

class SplashScreenViewController: UIViewController {
    
    fileprivate func setCaffeineLabel(_ caffeineLabel: UILabel, text: String) {
        caffeineLabel.frame = CGRect(x: 220, y: 220, width: 100, height: 80)
        caffeineLabel.font = UIFont(name: "Rubik-Bold", size: 68)
        caffeineLabel.textColor = .white
        caffeineLabel.translatesAutoresizingMaskIntoConstraints = false
        caffeineLabel.text = text
        caffeineLabel.textAlignment = .center
    }
    
    fileprivate func setCaffeineLabelConstraints(_ caffeineLabel: UILabel) {
        let margineGuide = view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            caffeineLabel.topAnchor.constraint(equalTo: margineGuide.topAnchor, constant: 480),
            caffeineLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            caffeineLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            caffeineLabel.heightAnchor.constraint(equalToConstant: 80),
            caffeineLabel.trailingAnchor.constraint(equalTo: margineGuide.trailingAnchor)
        ])
    }
    
    fileprivate func setBoltImageConstraints(_ imageView: UIImageView) {
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            imageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 58),
            imageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -500),
            imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 84),
            imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -84)
            
        ])
    }
    
    fileprivate func setBoltImageFrame(_ imageView: UIImageView) {
        imageView.frame = CGRect(x: 0, y: 0, width: 120, height: 120)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(named: "orangeMain")
        let image = UIImage(named: "bolt.png")
        let imageView = UIImageView(image: image!)
        let caffeineLabel = UILabel()
        
        self.setBoltImageFrame(imageView)
        
        self.view.addSubview(imageView)
        self.setBoltImageConstraints(imageView)
        
        self.setCaffeineLabel(caffeineLabel, text: "Caffeine")
        self.view.addSubview(caffeineLabel)
        self.setCaffeineLabelConstraints(caffeineLabel)
    }
}
