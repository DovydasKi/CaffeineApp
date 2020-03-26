//
//  CafeDrinkMenuViewController.swift
//  Caffeine
//
//  Created by Daniel Dluzhnevsky on 2020-03-20.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation
import UIKit

class Coffee {
    var imageView: UIImageView?
    var label: UILabel?

    init(imageView: UIImageView, label: UILabel) {
        self.imageView = imageView
        self.label = label
    }
}

private class MyTapGesture: UITapGestureRecognizer {
    var labelText: String?
}

class CafeDrinkMenuViewController: UIViewController {
    private lazy var searchBar: UISearchBar = self.initSearchBar()
    private lazy var titleLabel: UILabel = self.initTitleLabel()
    private lazy var coffeeArray: [Coffee] = self.initCoffeeArray()
    private lazy var firstColumnCoffeeStackView: UIStackView = initNthColumnCoffeeStackView(coffeArray: self.coffeeArray, sizeOfCoffeArray: self.coffeeArray.count, numberOfColumns: 2, isFirstColumn: true)
    private lazy var secondColumnCoffeeStackView: UIStackView = initNthColumnCoffeeStackView(coffeArray: self.coffeeArray, sizeOfCoffeArray: self.coffeeArray.count, numberOfColumns: 2, isFirstColumn: false)
    private lazy var imageStackView: UIStackView = self.initImageStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .white

        self.view.addSubview(self.searchBar)
        self.activateSearchBarConstraints()

        self.view.addSubview(titleLabel)
        self.activateTitleLabelConstraints()

        for item in coffeeArray {
            self.view.addSubview(item.imageView!)
            self.view.addSubview(item.label!)
        }

        self.view.addSubview(self.firstColumnCoffeeStackView)
        self.view.addSubview(self.secondColumnCoffeeStackView)

        self.view.addSubview(self.imageStackView)
        self.setImageStackViewConstraints()
        self.setTapGesturesForCoffeeImageView(coffeeArray: self.coffeeArray)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

}

//MARK: Helper functions
extension CafeDrinkMenuViewController {
    private func setTapGesturesForCoffeeImageView (coffeeArray: [Coffee]) {
        var tapArray = [MyTapGesture]()

        for _ in 0...coffeeArray.count - 1 {
            tapArray.append(MyTapGesture.init(target: self, action: #selector(turnOnSelectedScreen)))
        }

        for index in 0...coffeeArray.count - 1 {
            coffeeArray[index].imageView?.isUserInteractionEnabled = true
            coffeeArray[index].imageView?.addGestureRecognizer(tapArray[index])
            tapArray[index].labelText = (coffeeArray[index].label?.text)
        }
    }
}

//MARK: Button actions
extension CafeDrinkMenuViewController {
    @objc private func turnOnSelectedScreen(recognizer: MyTapGesture) {
        guard let labelText = recognizer.labelText else { return }
        let nextDetailedViewController = DetailedCoffeeViewController()
        switch labelText {
        case "Cappuccino":
            nextDetailedViewController.modalPresentationStyle = .automatic
            nextDetailedViewController.modalTransitionStyle = .coverVertical
            nextDetailedViewController.imageName = labelText
            self.present(nextDetailedViewController, animated: true, completion: nil)
        case "Latte":
            nextDetailedViewController.modalPresentationStyle = .automatic
            nextDetailedViewController.modalTransitionStyle = .coverVertical
            nextDetailedViewController.imageName = labelText
            self.present(nextDetailedViewController, animated: true, completion: nil)
        case "Black Coffee":
            nextDetailedViewController.modalPresentationStyle = .automatic
            nextDetailedViewController.modalTransitionStyle = .coverVertical
            nextDetailedViewController.imageName = labelText
            self.present(nextDetailedViewController, animated: true, completion: nil)
        case "White Coffee":
            nextDetailedViewController.modalPresentationStyle = .automatic
            nextDetailedViewController.modalTransitionStyle = .coverVertical
            nextDetailedViewController.imageName = labelText
            self.present(nextDetailedViewController, animated: true, completion: nil)
        case "Mocha":
            nextDetailedViewController.modalPresentationStyle = .automatic
            nextDetailedViewController.modalTransitionStyle = .coverVertical
            nextDetailedViewController.imageName = labelText
            self.present(nextDetailedViewController, animated: true, completion: nil)
        case "Flat White":
            nextDetailedViewController.modalPresentationStyle = .automatic
            nextDetailedViewController.modalTransitionStyle = .coverVertical
            nextDetailedViewController.imageName = labelText
            self.present(nextDetailedViewController, animated: true, completion: nil)
        default:
            return
        }
    }
}

//MARK: UI elements extension
extension CafeDrinkMenuViewController {
    private func initSearchBar() -> UISearchBar {
        let searchBar = UISearchBar()
        searchBar.sizeToFit()
        searchBar.delegate = self as? UISearchBarDelegate
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Ieškoti")
        searchBar[keyPath: \.searchTextField].font = UIFont(name: "Rubik-Medium", size: 17)
        searchBar[keyPath: \.searchTextField].textColor = UIColor(named: "mainOrange")
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchBarStyle = .minimal
        return searchBar
    }

    private func initTitleLabel() -> UILabel {
        let titleLabel = UILabel()
        titleLabel.text = "CAFFEINE"
        titleLabel.font = UIFont(name: "Rubik-Black", size: 32)
        titleLabel.textColor = UIColor(named: "orangeMain")
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .left
        titleLabel.contentMode = .scaleAspectFit
        return titleLabel
    }

    private func initCoffeeArray() -> [Coffee] {
        var coffeeArray = [Coffee]()

        for _ in 0...5 { coffeeArray.append(Coffee(imageView: UIImageView(), label: UILabel())) }

        coffeeArray[0].imageView?.image = #imageLiteral(resourceName: "cappuccino")
        coffeeArray[0].label?.text = "Cappuccino"
        coffeeArray[1].imageView?.image = #imageLiteral(resourceName: "latte")
        coffeeArray[1].label?.text = "Latte"
        coffeeArray[2].imageView?.image = #imageLiteral(resourceName: "blackCoffee")
        coffeeArray[2].label?.text = "Black Coffee"
        coffeeArray[3].imageView?.image = #imageLiteral(resourceName: "whiteCoffee")
        coffeeArray[3].label?.text = "White Coffee"
        coffeeArray[4].imageView?.image = #imageLiteral(resourceName: "mocha")
        coffeeArray[4].label?.text = "Mocha"
        coffeeArray[5].imageView?.image = #imageLiteral(resourceName: "flatWhite")
        coffeeArray[5].label?.text = "Flat White"

        for item in coffeeArray {
            item.imageView?.contentMode = .scaleAspectFill
            item.imageView?.layer.masksToBounds = true
            item.imageView?.layer.cornerRadius = 12.5
            item.imageView?.layer.shadowColor = UIColor.black.cgColor
            item.imageView?.layer.shadowOffset = CGSize(width: 0, height: 2)
            item.imageView?.layer.shadowRadius = 4
            item.imageView?.layer.shadowOpacity = 0.5
            item.label?.font = UIFont(name: "Rubik-Medium", size: 22)
            item.label?.textColor = UIColor(named: "orangeMain")
            item.imageView?.translatesAutoresizingMaskIntoConstraints = false
            item.imageView?.heightAnchor.constraint(equalToConstant: 116).isActive = true
            item.imageView?.widthAnchor.constraint(equalToConstant: 174).isActive = true
        }
        return coffeeArray
    }

    private func initNthColumnCoffeeStackView(coffeArray: [Coffee], sizeOfCoffeArray: Int, numberOfColumns: Int, isFirstColumn: Bool) -> UIStackView {
        let stackView = UIStackView()

        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 8
        if isFirstColumn {
            for coffeeItem in coffeeArray {
                guard let imageView = coffeeItem.imageView else { return stackView }
                guard let label = coffeeItem.label else { return stackView }
                stackView.addArrangedSubview(imageView)
                stackView.addArrangedSubview(label)
            }
        }
        else {
            for index in sizeOfCoffeArray / 2...sizeOfCoffeArray - 1 {
                guard let imageView = coffeArray[index].imageView else { return stackView }
                guard let label = coffeArray[index].label else { return stackView }
                stackView.addArrangedSubview(imageView)
                stackView.addArrangedSubview(label)
            }
        }
        return stackView
    }

    private func initImageStackView () -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.addArrangedSubview(self.firstColumnCoffeeStackView)
        stackView.addArrangedSubview(self.secondColumnCoffeeStackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
}

//MARK: Constraints extension
extension CafeDrinkMenuViewController {
    private func activateSearchBarConstraints() {
        NSLayoutConstraint.activate([
            self.searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 32.0),
            self.searchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.searchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)
            ])
    }

    private func activateTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor, constant: 16),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            ])
    }

    private func setImageStackViewConstraints() {
        NSLayoutConstraint.activate([
            self.imageStackView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 32),
            self.imageStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.imageStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
            ])
    }
}
