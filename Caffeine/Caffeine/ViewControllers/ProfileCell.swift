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
    lazy var content: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    private func setupLayout() {

        self.addSubview(self.content)
        self.setContentConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension ProfileCell {
    private func setContentConstraints() {
        NSLayoutConstraint.activate([
            self.content.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 64),
            self.content.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.content.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.content.heightAnchor.constraint(equalToConstant: 411)
            ])
    }

}

//extension ProfileCell {
//    private func initBackView() -> UIView {
//        let view = UserReservationView() as UIView
//
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }
//}
