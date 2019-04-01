//
//  HomeMovieCollectionViewController.swift
//  MovieProject
//
//  Created by Esraa Hassan on 3/27/19.
//  Copyright © 2019 Abdo Amin. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "movieCell"

class HomeMovieCollectionViewController: UICollectionViewController ,UICollectionViewDelegateFlowLayout{
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let fadeTextAnimation = CATransition()
        fadeTextAnimation.duration = 0.5
        fadeTextAnimation.type = kCATransitionFade
        navigationController?.navigationBar.layer.add(fadeTextAnimation, forKey: "fadeText")
        	navigationItem.title = "test 123"
        
        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MovieCollectionViewCell
        
        cell.image.image=UIImage(named:"1.jpg")
        //        cell.imageView.downloaded(from: self.movieList[indexPath.row].overview!, returnedDataProtocol:self)
        cell.layer.borderColor = UIColor.red.cgColor
        cell.layer.borderWidth = 7
        cell.layer.cornerRadius=15
        return cell
    }
    override func viewWillLayoutSubviews() {
//        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
     func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let kWhateverHeightYouWant = collectionView.bounds.size.height/2
        return CGSize(width: (collectionView.bounds.size.width/2 - CGFloat(15)), height: CGFloat(kWhateverHeightYouWant-63))
    }
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
}

