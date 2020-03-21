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

class CafeDrinkMenuViewController: UIViewController {
    
    private lazy var searchBar: UISearchBar = self.initSearchBar()
    
    private lazy var imageViewArray: [UIImageView] = initImageViewArray()
    private lazy var imageTitle: [UILabel] = initImageTitleArray()
    
    private lazy var coffeeArray: [Coffee] = initCoffeeArray()
    private lazy var firstColumnCoffeeStackView: [UIStackView] = initColumnCoffeeStackView(sizeOfCoffeArray: coffeeArray.count, numberOfColumns: 2, isFirstColumn: true)
    private lazy var secondColumnCoffeeStackView: [UIStackView] = initColumnCoffeeStackView(sizeOfCoffeArray: coffeeArray.count, numberOfColumns: 2, isFirstColumn: false)
    private lazy var firstColumnStackView: UIStackView = initFirstColumnStackView()
    private lazy var secondColumnStackView: UIStackView = initSecondColumnStackView()
    private lazy var imageStackView: UIStackView = initImageStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .white
        
        self.view.addSubview(self.searchBar)
        self.activateSearchBarConstraints()
        
        
        for item in coffeeArray {
            self.view.addSubview(item.imageView!)
            self.view.addSubview(item.label!)
        }
        
        for item in firstColumnCoffeeStackView {
            self.view.addSubview(item)
        }
        
        for item in secondColumnCoffeeStackView {
            self.view.addSubview(item)
        }
        
        
        self.view.addSubview(self.imageStackView)
        self.setImageStackViewConstraints()
        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension CafeDrinkMenuViewController {
    private func initSearchBar() -> UISearchBar {
        let searchBar = UISearchBar()
        searchBar.sizeToFit()
        searchBar.delegate = self as? UISearchBarDelegate
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Ieškoti")
        searchBar[keyPath: \.searchTextField].font = UIFont(name: "Rubik-Medium", size: 17)
        searchBar[keyPath: \.searchTextField].textColor = UIColor(named: "mainOrange")
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }
    
    private func initCoffeeArray() -> [Coffee] {
        var coffeeArray = [Coffee]()
        
        for _ in 1...6 {
            coffeeArray.append(Coffee(imageView: UIImageView(), label: UILabel()))
        }
        
        coffeeArray[0].imageView?.image = #imageLiteral(resourceName: "cappuccino")
        coffeeArray[0].label?.text = "Cappuccino"
        coffeeArray[1].imageView?.image = #imageLiteral(resourceName: "latte")
        coffeeArray[1].label?.text = "Latte"
        coffeeArray[2].imageView?.image = #imageLiteral(resourceName: "dark")
        coffeeArray[2].label?.text = "Black Coffee"
        coffeeArray[3].imageView?.image = #imageLiteral(resourceName: "white")
        coffeeArray[3].label?.text = "White Coffee"
        coffeeArray[4].imageView?.image = #imageLiteral(resourceName: "mocha")
        coffeeArray[4].label?.text = "Mocha"
        coffeeArray[5].imageView?.image = #imageLiteral(resourceName: "flatWhite")
        coffeeArray[5].label?.text = "Flat White"
        
        for item in coffeeArray {
            item.imageView!.contentMode = .scaleAspectFill
            item.imageView!.layer.masksToBounds = true
            item.imageView!.translatesAutoresizingMaskIntoConstraints = false
            item.imageView!.heightAnchor.constraint(equalToConstant: 116).isActive = true
            item.imageView!.widthAnchor.constraint(equalToConstant: 174).isActive = true
        }
        
        return coffeeArray
    }
    
    private func initColumnCoffeeStackView(sizeOfCoffeArray: Int, numberOfColumns: Int, isFirstColumn: Bool) -> [UIStackView] {
        var stackView = [UIStackView]()
        
        for _ in 1...sizeOfCoffeArray / numberOfColumns {
            stackView.append(UIStackView())
        }
        
        if isFirstColumn {
            
        }
        for stackView in stackView {
            stackView.axis = NSLayoutConstraint.Axis.vertical
            stackView.distribution = UIStackView.Distribution.equalSpacing
            stackView.alignment = UIStackView.Alignment.center
            stackView.spacing = 4
            if isFirstColumn {
                for item in self.coffeeArray {
                    stackView.addArrangedSubview(item.imageView!)
                    stackView.addArrangedSubview(item.label!)
                }
            }
            else {
                for index in sizeOfCoffeArray/2...sizeOfCoffeArray - 1  {
                    stackView.addArrangedSubview(self.coffeeArray[index].imageView!)
                    stackView.addArrangedSubview(self.coffeeArray[index].label!)
                }
            }
            
        }
        return stackView
    }
    

    
    private func initImageViewArray() -> [UIImageView] {
        var imageViewArray = [UIImageView]()
        
        imageViewArray.append(UIImageView(image: #imageLiteral(resourceName: "cappuccino")))
        imageViewArray.append(UIImageView(image: #imageLiteral(resourceName: "latte")))
        imageViewArray.append(UIImageView(image: #imageLiteral(resourceName: "dark")))
        imageViewArray.append(UIImageView(image: #imageLiteral(resourceName: "white")))
        imageViewArray.append(UIImageView(image: #imageLiteral(resourceName: "mocha")))
        imageViewArray.append(UIImageView(image: #imageLiteral(resourceName: "flatWhite")))
        
        
        for image in imageViewArray {
            image.contentMode = .scaleAspectFill
            image.layer.masksToBounds = true
            image.translatesAutoresizingMaskIntoConstraints = false
            image.heightAnchor.constraint(equalToConstant: 116).isActive = true
            image.widthAnchor.constraint(equalToConstant: 174).isActive = true
        }
        
        return imageViewArray
    }
    
    private func initImageTitleArray() -> [UILabel] {
        var labelArray = [UILabel]()
        
        for _ in 1...self.imageViewArray.count {
            labelArray.append(UILabel())
        }
        labelArray[0].text = "Cappuccino"
        labelArray[1].text = "Latte"
        labelArray[2].text = "Black Coffee"
        labelArray[3].text = "White Coffee"
        labelArray[4].text = "Mocha"
        labelArray[5].text = "Flat White"
        
        
        return labelArray
    }
    
    
    
    private func initFirstColumnStackView () -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 48
        stackView.addArrangedSubview(self.firstColumnCoffeeStackView[0])
        stackView.addArrangedSubview(self.firstColumnCoffeeStackView[1])
        stackView.addArrangedSubview(self.firstColumnCoffeeStackView[2])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    private func initSecondColumnStackView () -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 48
        stackView.addArrangedSubview(self.secondColumnCoffeeStackView[0])
        stackView.addArrangedSubview(self.secondColumnCoffeeStackView[1])
        stackView.addArrangedSubview(self.secondColumnCoffeeStackView[2])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    private func initImageStackView () -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 16
        stackView.addArrangedSubview(self.firstColumnStackView)
        stackView.addArrangedSubview(self.secondColumnStackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
}

extension CafeDrinkMenuViewController {
    private func activateSearchBarConstraints() {
        NSLayoutConstraint.activate([
            self.searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 32.0),
            self.searchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.searchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)
        ])
    }
    
    private func setImageStackViewConstraints() {
        NSLayoutConstraint.activate([
            self.imageStackView.topAnchor.constraint(equalTo: self.searchBar.topAnchor, constant: 96),
            self.imageStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.imageStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)
        ])
    }
    
}
