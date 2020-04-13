//
//  RegistrationImageSelectionViewModel.swift
//  Caffeine
//
//  Created by Daniel Dluzhnevsky on 2020-03-11.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation
import UIKit

class RegistrationImageSelectionViewModel {
	private static let skipButtonTitle = "Praleisti"
	private static let chooseButtonTitle = "Pasirinkti"
	private static let chooseAcountPhotoText = "Išsirinkite paskyros nuotrauką"
	
    public func chooseImage(imageArray: inout [UIImageView: Bool], tapGestureRecognizer: UITapGestureRecognizer) -> [UIImageView: Bool] {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        if imageArray.contains(where: { $0.value == false }) && tappedImage.layer.shadowColor == UIColor.black.cgColor {
            if imageArray.contains(where: { $0.key.layer.shadowColor == UIColor.white.cgColor }) {
                return imageArray
            }
            self.setActiveShadow(imageView: tappedImage)
            self.setLockForSelectedImage(imageArray: &imageArray, tappedImage: tappedImage)
        }
        else {
            self.setShadow(imageView: tappedImage)
            self.removeLockForSelectedImage(imageArray: &imageArray, tappedImage: tappedImage)
        }
        return imageArray
    }

    private func setLockForSelectedImage(imageArray: inout [UIImageView: Bool], tappedImage: UIImageView) {
        for key in imageArray.keys { imageArray[key] = true }
        imageArray[tappedImage] = false
    }

    private func removeLockForSelectedImage(imageArray: inout [UIImageView: Bool], tappedImage: UIImageView) {
        for key in imageArray.keys { imageArray[key] = false }
    }

    public func setShadow(imageView: UIImageView) {
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOffset = CGSize(width: 0, height: 2)
        imageView.layer.shadowRadius = 4
        imageView.layer.shadowOpacity = 0.5
    }

    public func setActiveShadow(imageView: UIImageView) {
        imageView.layer.shadowColor = UIColor.white.cgColor
        imageView.layer.shadowOffset = CGSize(width: 0, height: 0)
        imageView.layer.shadowRadius = 16
        imageView.layer.shadowOpacity = 1
    }
}

extension RegistrationImageSelectionViewModel {
	public var skipButtonTitle: String {
		type(of: self).skipButtonTitle
	}
	
	public var chooseButtonTitle: String {
		type(of: self).chooseButtonTitle
	}
	
	public var chooseAcountPhotoText: String {
		type(of: self).chooseAcountPhotoText
	}
}
