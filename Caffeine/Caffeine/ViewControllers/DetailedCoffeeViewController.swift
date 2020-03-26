//
//  DetailedCappuccinoViewController.swift
//  Caffeine
//
//  Created by Daniel Dluzhnevsky on 2020-03-24.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation
import UIKit

private class MyTapGesture: UITapGestureRecognizer {
    var imageView: UIImageView?
}

class DetailedCoffeeViewController: UIViewController {
    var imageName: String?
    private lazy var coffeeImage: UIImageView = self.initCoffeeImage()
    private lazy var coffeeLabel: UILabel = self.initCoffeeLabel()
    private lazy var priceTagLabel: UILabel = self.initPriceTagLabel()
    private lazy var cupSizesArray: [UIImageView] = self.initCupSizesArray()
    private lazy var cupSizesDict: [UIImageView: Bool] = self.initCupSizesDict()
    private lazy var cupSizesStackView: UIStackView = self.initCupSizesStackView()
    private lazy var descriptionTextView: UITextView = self.initDescriptionTextView()
    private var detailedCoffeeViewModel = DetailedCoffeeViewModel()
    private lazy var cancelButton: UIButton = self.initCancelButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .white

        guard let imageName = self.imageName else { return }

        self.coffeeImage.image = UIImage(named: imageName.replacingOccurrences(of: " ", with: "").firstLowercased)
        self.view.addSubview(self.coffeeImage)
        self.activateCoffeeImageConstraints()

        self.coffeeLabel.text = imageName
        self.view.addSubview(self.coffeeLabel)
        self.activateCoffeeLabelConstraints()

        for item in cupSizesArray {
            self.view.addSubview(item)
        }

        self.view.addSubview(self.cupSizesStackView)
        self.setCupSizesStackViewConstraints()

        self.setTapGesturesForCoffeeSizesImageView(cupSizesArray: self.cupSizesArray)

        self.setPriceTag(imageView: self.coffeeImage, priceTagLabel: self.priceTagLabel)

        self.priceTagLabel.text = self.detailedCoffeeViewModel.setDefaultPrice(imageName: imageName, priceTagLabel: self.priceTagLabel)

        self.view.addSubview(self.descriptionTextView)

        self.setDescriptionTextViewConstraints()

        self.view.addSubview(self.cancelButton)
        self.setLogoutButtonConstraints()
    }
}

extension StringProtocol {
    var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
    var firstLowercased: String { prefix(1).lowercased() + dropFirst() }
}

extension UITextView {
    func adjustUITextViewHeight() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.sizeToFit()
        self.isScrollEnabled = false
    }
}
//MARK: Helper functions
extension DetailedCoffeeViewController {
    private func setPriceTag(imageView: UIImageView, priceTagLabel: UILabel) {
        imageView.addSubview(priceTagLabel)
        priceTagLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -16).isActive = true
        priceTagLabel.rightAnchor.constraint(equalTo: imageView.rightAnchor, constant: -16).isActive = true
        priceTagLabel.heightAnchor.constraint(equalToConstant: 48).isActive = true
        priceTagLabel.widthAnchor.constraint(equalToConstant: 128).isActive = true
    }

    private func initCupSizesDict() -> [UIImageView: Bool] {
        var dict = [UIImageView: Bool]()

        for index in 0...self.cupSizesArray.count - 1 {
            dict[cupSizesArray[index]] = false
        }
        dict[cupSizesArray[1]] = true
        return dict
    }

    private func setTapGesturesForCoffeeSizesImageView (cupSizesArray: [UIImageView]) {
        var tapArray = [MyTapGesture]()

        for _ in 0...cupSizesArray.count - 1 {
            tapArray.append(MyTapGesture.init(target: self, action: #selector(coffeeTapped)))
        }

        for index in 0...cupSizesArray.count - 1 {
            cupSizesArray[index].isUserInteractionEnabled = true
            cupSizesArray[index].addGestureRecognizer(tapArray[index])
            tapArray[index].imageView = (cupSizesArray[index])
        }
    }
}

//MARK: Button actions
extension DetailedCoffeeViewController {
    @objc private func coffeeTapped(tapGestureRecognizer: MyTapGesture) {
        guard let imageView = tapGestureRecognizer.imageView else { return }
        guard let imageName = self.imageName else { return }

        self.detailedCoffeeViewModel.setPriceForSelectedCoffee(imageView: imageView, cupSizesArray: &self.cupSizesArray, cupSizesDict: &self.cupSizesDict, imageName: imageName, priceTagLabel: &self.priceTagLabel)
    }
    
    @objc private func backToPreviousScreen() {
        dismiss(animated: true, completion: nil)
    }
}

//MARK: UI elements extension
extension DetailedCoffeeViewController {
    private func initCoffeeImage() -> UIImageView {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12.5
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }

    private func initCoffeeLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Black", size: 32)
        label.textColor = UIColor(named: "orangeMain")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.contentMode = .scaleAspectFit
        return label
    }

    private func initPriceTagLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Medium", size: 32)
        label.textColor = UIColor(named: "orangeMain")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.backgroundColor = #colorLiteral(red: 0.9058029056, green: 0.9059332013, blue: 0.9057744145, alpha: 0.8630136986)
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        return label
    }

    private func initCupSizesArray() -> [UIImageView] {
        var cupSizesImageViewArray = [UIImageView]()

        for _ in 0...2 {
            cupSizesImageViewArray.append(UIImageView())
        }

        cupSizesImageViewArray[0].image = #imageLiteral(resourceName: "sCupOutline")
        cupSizesImageViewArray[1].image = #imageLiteral(resourceName: "mCupFilled")
        cupSizesImageViewArray[2].image = #imageLiteral(resourceName: "lCupOutline")

        for item in cupSizesImageViewArray {
            item.translatesAutoresizingMaskIntoConstraints = false
            item.heightAnchor.constraint(equalToConstant: 64).isActive = true
            item.widthAnchor.constraint(equalToConstant: 44).isActive = true
        }

        return cupSizesImageViewArray
    }

    private func initCupSizesStackView () -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 16

        for index in 0...self.cupSizesArray.count - 1 {
            stackView.addArrangedSubview(self.cupSizesArray[index])
        }

        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }

    private func initDescriptionTextView () -> UITextView {
        let textView = UITextView()
        textView.text = "Etiopijos ūkininkų užauginama šalies kava buvo griežtai registruojama ir eksportuojama keletu pavadinimu – Yirgacheffe, Sidamo, Harar regionų vardais. \nTokie išskirtiniai derliai buvo atsekami pagal tikslius vietovardžius ir ūkininkų pavardes"
        textView.font = UIFont(name: "Rubik-Medium", size: 16)
        textView.textAlignment = .justified
        textView.textColor = UIColor(named: "orangeMain")
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        textView.layer.cornerRadius = textView.frame.size.height / 2
        textView.clipsToBounds = false
        textView.layer.cornerRadius = 12.5
        textView.layer.shadowOpacity = 0.4
        textView.layer.shadowRadius = 4
        textView.layer.shadowOffset = CGSize(width: 0, height: 2)
        textView.adjustUITextViewHeight()
        return textView
    }

    private func initCancelButton() -> UIButton {
        let button: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 304, height: 42))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 34.5
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.5
        button.backgroundColor = UIColor(named: "orangeMain")
        button.setTitle("Atšaukti", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Rubik-Bold", size: UIView.margin(of: [20, 22, 24]))
        button.addTarget(self, action: #selector(self.backToPreviousScreen), for: .touchUpInside)
        return button
    }
}

//MARK: Constraints extension
extension DetailedCoffeeViewController {
    private func activateCoffeeImageConstraints() {
        NSLayoutConstraint.activate([
            self.coffeeImage.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 32.0),
            self.coffeeImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.coffeeImage.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            self.coffeeImage.heightAnchor.constraint(equalToConstant: 300)
            ])
    }

    private func activateCoffeeLabelConstraints() {
        NSLayoutConstraint.activate([
            self.coffeeLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.coffeeLabel.topAnchor.constraint(equalTo: self.coffeeImage.bottomAnchor, constant: 16)
            ])
    }

    private func setCupSizesStackViewConstraints() {
        NSLayoutConstraint.activate([
            self.cupSizesStackView.topAnchor.constraint(equalTo: self.coffeeLabel.bottomAnchor, constant: 16),
            self.cupSizesStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            ])
    }

    private func setDescriptionTextViewConstraints() {
        NSLayoutConstraint.activate([
            self.descriptionTextView.topAnchor.constraint(equalTo: self.cupSizesStackView.bottomAnchor, constant: 16),
            self.descriptionTextView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.descriptionTextView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)
            ])
    }

    private func setLogoutButtonConstraints() {
        NSLayoutConstraint.activate([
            self.cancelButton.topAnchor.constraint(equalTo: self.descriptionTextView.bottomAnchor, constant: 64),
            self.cancelButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.cancelButton.widthAnchor.constraint(equalToConstant: 254),
            self.cancelButton.heightAnchor.constraint(equalToConstant: 69)
            ])
    }
}
