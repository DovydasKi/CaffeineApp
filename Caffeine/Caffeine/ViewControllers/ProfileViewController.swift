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
    private var contentViewsArray =  [Profile]()
    
    lazy var test: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentViewsArray.append(Profile(contentView: UserReservationView() as UIView))
        self.contentViewsArray.append(Profile(contentView: UserReservationView() as UIView))
       
        navigationController?.navigationBar.isHidden = true
        collectionView?.backgroundColor = .white
        //collectionView?.register(ProfileCell.self, forCellWithReuseIdentifier: "cellId")
        
        collectionView?.register(ProfileCell.self, forCellWithReuseIdentifier: "Cell")
        
        
        print(contentViewsArray)
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
        guard let contentView = self.contentViewsArray[indexPath.row].contentView else { return cell}
        cell.content = contentView
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
