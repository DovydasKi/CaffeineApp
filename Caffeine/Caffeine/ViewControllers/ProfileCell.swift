//
//  ProfileCell.swift
//  Caffeine
//
//  Created by Daniel Dluzhnevsky on 2020-03-31.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation
import UIKit

class ProfileCell: UICollectionViewCell {

    //private lazy var backView: UIView = initBackView()
    private var profileCell = UserReservationView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    

    private func setupLayout() {

        self.addSubview(self.profileCell)
        
        //addSubview(self.profileCell)
      
        self.profileCell.translatesAutoresizingMaskIntoConstraints = false
        self.profileCell.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 64).isActive = true
        
        self.profileCell.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        self.profileCell.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        self.profileCell.heightAnchor.constraint(equalToConstant: 411).isActive = true
        //self.profileCell.translatesAutoresizingMaskIntoConstraints = false
//        self.profileCell.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 200).isActive = true
//        self.profileCell.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        //self.profileCell.heightAnchor.constraint(equalToConstant: 200).isActive = true


    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    


}

extension ProfileCell {
    private func initBackView() -> UIView {
        let view = UserReservationView() as UIView

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}
