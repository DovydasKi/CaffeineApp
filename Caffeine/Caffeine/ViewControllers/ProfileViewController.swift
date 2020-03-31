//
//  ProfileViewController.swift
//  Caffeine
//
//  Created by Daniel Dluzhnevsky on 2020-03-31.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation
import UIKit


private var contentViewsArray =  [profileView]()

class ProfileViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        collectionView?.backgroundColor = .white
        collectionView?.register(ProfileCell.self, forCellWithReuseIdentifier: "cellId")

        collectionView?.isPagingEnabled = true
        collectionView?.showsHorizontalScrollIndicator = false

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return contentViewsArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? ProfileCell else { fatalError("Unabel to create cell") }
        cell.reservationView = self.contentViewsArray[indexPath.row]
        cell.topicView = self.contentViewsArray[indexPath.row]
        cell.informationView = self.contentViewsArray[indexPath.row]
        return cell
    }

//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 3
//    }

//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
//
//
//        return cell
//    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}
