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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentViewsArray.append(Profile(contentView: UserReservationView() as UIView))
        self.contentViewsArray.append(Profile(contentView: UserMeetupTopicsView() as UIView))
       
        navigationController?.navigationBar.isHidden = true
        collectionView?.backgroundColor = .white

        
        collectionView?.register(ProfileCell.self, forCellWithReuseIdentifier: "Cell")
        
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
        cell.addContent(content: self.contentViewsArray[indexPath.row].contentView)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}
