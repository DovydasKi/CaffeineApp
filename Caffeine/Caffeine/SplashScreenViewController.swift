//
//  SplashScreenViewController.swift
//  Caffeine
//
//  Created by Daniel Dluzhnevsky on 2020-03-02.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import UIKit

class SplashScreenViewController: UIViewController {

    fileprivate func centerBoltImage(_ imageView: UIImageView) {
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 200)
        imageView.frame.origin.x = view.bounds.midX - imageView.bounds.midX
        imageView.frame.origin.y = view.bounds.midX - imageView.bounds.midX
    }
    
    fileprivate func setCaffeineLabel(_ caffeineLabel: UILabel) {
        caffeineLabel.frame = CGRect(x: 220, y: 220, width: 100, height: 80)
        caffeineLabel.font = UIFont(name: "Rubik-Bold", size: 88)
        caffeineLabel.textColor = .white
        
        caffeineLabel.translatesAutoresizingMaskIntoConstraints = false
        caffeineLabel.text = "Caffeine"
        
        caffeineLabel.textAlignment = .center
    }
    
    fileprivate func setCaffeineLabelConstraints(_ caffeineLabel: UILabel) {
        let margineGuide = view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            caffeineLabel.topAnchor.constraint(equalTo: margineGuide.topAnchor, constant: 480),
            caffeineLabel.leadingAnchor.constraint(equalTo: margineGuide.leadingAnchor),
            caffeineLabel.heightAnchor.constraint(equalToConstant: 80),
            caffeineLabel.trailingAnchor.constraint(equalTo: margineGuide.trailingAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(named: "orangeMain")
        let image = UIImage(named: "bolt.png")
        let imageView = UIImageView(image: image!)
        let caffeineLabel = UILabel()
    
        centerBoltImage(imageView)
        view.addSubview(imageView)
        
    
        setCaffeineLabel(caffeineLabel)
        view.addSubview(caffeineLabel)
        
        setCaffeineLabelConstraints(caffeineLabel)
        
       

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
