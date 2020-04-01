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
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func addContent(content: UIView){
        self.addSubview(content)
        content.translatesAutoresizingMaskIntoConstraints = false
        self.setContentConstraints(view: content)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension ProfileCell {
    private func setContentConstraints(view: UIView) {
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 64),
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            view.heightAnchor.constraint(equalToConstant: 411)
            ])
    }

}
