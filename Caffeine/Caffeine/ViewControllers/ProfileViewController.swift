//
//  ProfileViewController.swift
//  Caffeine
//
//  Created by Daniel Dluzhnevsky on 2020-03-31.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation
import UIKit


private class MyTapGesture: UITapGestureRecognizer {
    var buttonView: UIView?
}

class ProfileViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private lazy var profilePicture: UIImageView = self.initProfilePicture()
    private lazy var fullNameLabel: UILabel = self.initFullNameLabel()
    private lazy var firstButton: UIView = self.initFirstButton()
    private lazy var secondButton: UIView = self.initSecondButton()
    private lazy var thirdButton: UIView = self.initThirdButton()
    private lazy var menuView: UIView = self.initMenuView()
    private var contentViewsArray = [Profile]()
    private var profileViewModel = ProfileViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentViewsArray.append(Profile(contentView: UserReservationView()))
        self.contentViewsArray.append(Profile(contentView: MeetupTopicsView(frame: .zero, multiple: false)))
        self.contentViewsArray.append(Profile(contentView: UserInformationView()))
        navigationController?.navigationBar.isHidden = true
        self.configureProfilePicture()
        self.configureFullNameLabel()
        self.configureMenuView()
        self.configureCollectionView()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contentViewsArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? ProfileCell else { fatalError("Unabel to create cell") }
        cell.addContent(content: self.contentViewsArray[indexPath.row].contentView)


        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 411)
    }

    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var visibleRect = CGRect()

        visibleRect.origin = collectionView.contentOffset
        visibleRect.size = collectionView.bounds.size

        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)

        guard let indexPath = collectionView.indexPathForItem(at: visiblePoint) else { return }

        print(indexPath)
        self.setAllButtonsInactive()
        switch indexPath {
        case [0, 0]:
            
            UIView.animate(withDuration: 0.2) {
                self.firstButton.backgroundColor = .white
            }
        case [0, 1]:
            UIView.animate(withDuration: 0.2) {
                self.secondButton.backgroundColor = .white
            }
            
        case [0, 2]:
            UIView.animate(withDuration: 0.2) {
               self.thirdButton.backgroundColor = .white
            }
            
        default:
            break
        }
    }
}

//MARK: Button actions
extension ProfileViewController {
    @objc private func firstButtonTap(tapGestureRecognizer: MyTapGesture) {
        guard let buttonView = tapGestureRecognizer.buttonView else { return }
        self.setAllButtonsInactive()
        self.setActiveButton(buttonView: buttonView)

        self.collectionView.scrollToItem(at: [0, 0] as IndexPath, at: .left, animated: true)
    }

    @objc private func secondButtonTap(tapGestureRecognizer: MyTapGesture) {
        guard let buttonView = tapGestureRecognizer.buttonView else { return }
        self.setAllButtonsInactive()
        self.setActiveButton(buttonView: buttonView)
        self.collectionView.scrollToItem(at: [0, 1] as IndexPath, at: .left, animated: true)

    }

    @objc private func thirdButtonTap(tapGestureRecognizer: MyTapGesture) {
        guard let buttonView = tapGestureRecognizer.buttonView else { return }
        self.setAllButtonsInactive()
        self.setActiveButton(buttonView: buttonView)
        self.collectionView.scrollToItem(at: [0, 2] as IndexPath, at: .left, animated: true)
    }
}

extension ProfileViewController {
    private func setActiveButton(buttonView: UIView) {
        buttonView.backgroundColor = .white
    }

    private func setAllButtonsInactive() {
        self.firstButton.backgroundColor = .clear
        self.secondButton.backgroundColor = .clear
        self.thirdButton.backgroundColor = .clear
    }
}

//MARK: UI configuratrion
extension ProfileViewController {
    private func configureCollectionView() {
        collectionView?.backgroundColor = .white
        collectionView?.register(ProfileCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView?.isPagingEnabled = true
        collectionView?.showsHorizontalScrollIndicator = false

        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.topAnchor.constraint(equalTo: self.menuView.bottomAnchor, constant: 16).isActive = true
        self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.collectionView.heightAnchor.constraint(equalToConstant: 411).isActive = true
    }
    
    private func configureProfilePicture() {
        self.view.addSubview(self.profilePicture)
        self.activateProfilePictureConstraints()
    }

    private func configureFullNameLabel() {
        self.view.addSubview(self.fullNameLabel)
        self.activateFullNameLabelConstraints()
    }

    private func configureMenuView() {
        self.view.addSubview(self.menuView)
        self.activateMenuViewConstraints()
        self.configureFirstButton()
        self.configureSecondButton()
        self.configureThirdButton()
    }
    
    private func configureFirstButton() {
        self.menuView.addSubview(self.firstButton)
        self.activateFirstButtonConstraints()
    }

    private func configureSecondButton() {
        self.menuView.addSubview(self.secondButton)
        self.activateSecondButtonConstraints()
    }

    private func configureThirdButton() {
        self.menuView.addSubview(self.thirdButton)
        self.activateThirdButtonConstraints()
    }
}
//MARK: UI elements extension
extension ProfileViewController {
    private func initProfilePicture() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "profileImage6")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOffset = CGSize(width: 0, height: 2)
        imageView.layer.shadowRadius = 4
        imageView.layer.shadowOpacity = 0.5
        return imageView
    }

    private func initFullNameLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Bold", size: UIView.margin(of: [20, 24, 28]))
        label.text = self.profileViewModel.fullNameTitle
        label.textColor = UIColor(named: "orangeMain")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.contentMode = .scaleAspectFit
        return label
    }

    private func initMenuView() -> UIView {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9176470588, green: 0.9176470588, blue: 0.9254901961, alpha: 1)
        view.layer.cornerRadius = 12.5

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }

    private func initFirstButton() -> UIView {
        let view = UIView()
        let label = UILabel()

        view.backgroundColor = .white
        view.layer.cornerRadius = 12.5

        label.font = UIFont(name: "Rubik-Bold", size: 14)
        label.text = self.profileViewModel.firstButtonTitle
        label.textColor = .black
        label.textAlignment = .center

        view.addSubview(label)

        label.translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        let tap = MyTapGesture.init(target: self, action: #selector(firstButtonTap))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tap)
        tap.buttonView = view
        return view
    }

    private func initSecondButton() -> UIView {
        let view = UIView()
        let label = UILabel()

        view.backgroundColor = .clear
        view.layer.cornerRadius = 12.5

        label.font = UIFont(name: "Rubik-Bold", size: 14)
        label.text = self.profileViewModel.secondButtonTitle
        label.textColor = .black
        label.textAlignment = .center
        view.addSubview(label)

        label.translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        let tap = MyTapGesture.init(target: self, action: #selector(secondButtonTap))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tap)
        tap.buttonView = view
        return view
    }

    private func initThirdButton() -> UIView {
        let view = UIView()
        let label = UILabel()

        view.backgroundColor = .clear
        view.layer.cornerRadius = 12.5

        label.font = UIFont(name: "Rubik-Bold", size: 14)
        label.text = self.profileViewModel.thirdButtonTitle
        label.textColor = .black
        label.textAlignment = .center
        view.addSubview(label)

        label.translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        let tap = MyTapGesture.init(target: self, action: #selector(thirdButtonTap))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tap)
        tap.buttonView = view
        return view
    }
}

//MARK: Constraints extension
extension ProfileViewController {
    private func activateProfilePictureConstraints() {
        NSLayoutConstraint.activate([
            self.profilePicture.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16),
            self.profilePicture.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.profilePicture.heightAnchor.constraint(equalToConstant: 144),
            self.profilePicture.widthAnchor.constraint(equalToConstant: 144)
            ])
    }

    private func activateFullNameLabelConstraints() {
        NSLayoutConstraint.activate([
            self.fullNameLabel.topAnchor.constraint(equalTo: self.profilePicture.bottomAnchor, constant: 16),
            self.fullNameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            ])
    }

    private func activateMenuViewConstraints() {
        NSLayoutConstraint.activate([
            self.menuView.topAnchor.constraint(equalTo: self.fullNameLabel.bottomAnchor, constant: 32),
            self.menuView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.menuView.heightAnchor.constraint(equalToConstant: 45),
            self.menuView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.menuView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)
            ])
    }

    private func activateFirstButtonConstraints() {
        NSLayoutConstraint.activate([
            self.firstButton.topAnchor.constraint(equalTo: self.menuView.topAnchor, constant: 4),
            self.firstButton.widthAnchor.constraint(equalToConstant: 123),
            self.firstButton.bottomAnchor.constraint(equalTo: self.menuView.bottomAnchor, constant: -4),
            self.firstButton.leadingAnchor.constraint(equalTo: self.menuView.leadingAnchor, constant: 4)
            ])
    }

    private func activateSecondButtonConstraints() {
        NSLayoutConstraint.activate([
            self.secondButton.centerXAnchor.constraint(equalTo: self.menuView.centerXAnchor),
            self.secondButton.widthAnchor.constraint(equalToConstant: 123),
            self.secondButton.topAnchor.constraint(equalTo: self.menuView.topAnchor, constant: 4),
            self.secondButton.bottomAnchor.constraint(equalTo: self.menuView.bottomAnchor, constant: -4)
            ])
    }

    private func activateThirdButtonConstraints() {
        NSLayoutConstraint.activate([
            self.thirdButton.topAnchor.constraint(equalTo: self.menuView.topAnchor, constant: 4),
            self.thirdButton.widthAnchor.constraint(equalToConstant: 123),
            self.thirdButton.bottomAnchor.constraint(equalTo: self.menuView.bottomAnchor, constant: -4),
            self.thirdButton.trailingAnchor.constraint(equalTo: self.menuView.trailingAnchor, constant: -4)
            ])
    }
}

