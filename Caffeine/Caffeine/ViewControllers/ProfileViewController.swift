//
//  ProfileViewController.swift
//  Caffeine
//
//  Created by Daniel Dluzhnevsky on 2020-03-31.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation
import UIKit




class ProfileViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private lazy var profilePicture: UIImageView = self.initProfilePicture()
    private lazy var fullNameLabel: UILabel = self.initFullNameLabel()
    private var contentViewsArray = [Profile]()
    private var menuBar = ProfileMenuBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentViewsArray.append(Profile(contentView: UserReservationView()))
        self.contentViewsArray.append(Profile(contentView: UserMeetupTopicsView()))
        self.contentViewsArray.append(Profile(contentView: UserInformationView()))
        navigationController?.navigationBar.isHidden = true
        
        self.configureProfilePicture()
        self.configureFullNameLabel()
        self.confugureMenuBar()
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
    
}
//MARK: UI configuratrion
extension ProfileViewController {
    private func configureCollectionView() {
        collectionView?.backgroundColor = .white
        collectionView?.register(ProfileCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView?.isPagingEnabled = true
        collectionView?.showsHorizontalScrollIndicator = false
        
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.topAnchor.constraint(equalTo: self.menuBar.bottomAnchor, constant: 16).isActive = true
        self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.collectionView.heightAnchor.constraint(equalToConstant: 411).isActive = true
    }
    private func configureProfilePicture() {
        self.view.addSubview(self.profilePicture)
        self.setProfilePictureConstraints()
    }

    private func configureFullNameLabel() {
        self.view.addSubview(self.fullNameLabel)
        self.setFullNameLabelConstraints()
    }
    
    private func confugureMenuBar() {
        self.view.addSubview(self.menuBar)
        self.menuBar.reservationButton.backgroundColor = .green
        self.menuBar.translatesAutoresizingMaskIntoConstraints = false
        self.setMenuBarConstraints()
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
        label.text = "Vardenis Pavardenis"
        label.textColor = UIColor(named: "orangeMain")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.contentMode = .scaleAspectFit
        return label
    }
}

extension ProfileViewController {
    private func setProfilePictureConstraints() {
        NSLayoutConstraint.activate([
            self.profilePicture.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16),
            self.profilePicture.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.profilePicture.heightAnchor.constraint(equalToConstant: 144),
            self.profilePicture.widthAnchor.constraint(equalToConstant: 144)
            ])
    }

    private func setFullNameLabelConstraints() {
        NSLayoutConstraint.activate([
            self.fullNameLabel.topAnchor.constraint(equalTo: self.profilePicture.bottomAnchor, constant: 16),
            self.fullNameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            ])
    }
    
    private func setMenuBarConstraints() {
        NSLayoutConstraint.activate([
            self.menuBar.heightAnchor.constraint(equalToConstant: 45),
            self.menuBar.topAnchor.constraint(equalTo: self.fullNameLabel.bottomAnchor, constant: 16),
            self.menuBar.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.menuBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.menuBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)
            ])
    }
}

