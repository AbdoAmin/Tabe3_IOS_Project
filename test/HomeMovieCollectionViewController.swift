//
//  HomeMovieCollectionViewController.swift
//  MovieProject
//
//  Created by Esraa Hassan on 3/27/19.
//  Copyright © 2019 Abdo Amin. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
import SwiftyJSON

private let reuseIdentifier = "movieCell"

class HomeMovieCollectionViewController: UICollectionViewController ,UICollectionViewDelegateFlowLayout{
    var moviesJsonList:Array<MoviePojo> = []

    override func viewDidLoad() {
        super.viewDidLoad()
//        let fadeTextAnimation = CATransition()
//        fadeTextAnimation.duration = 0.5
//        fadeTextAnimation.type = kCATransitionFade
//        navigationController?.navigationBar.layer.add(fadeTextAnimation, forKey: "fadeText")
//            navigationItem.title = "test 123"
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        DispatchQueue.main.async {
            Alamofire.request(AppConstants.BASE_URL+"movie/top_rated?api_key="+AppConstants.API_KEY).responseJSON { (response) in
                
                  let jsonReponse = JSON(response.result.value!)
                print(jsonReponse["results"].array?.count)
                   //self.moviesJsonList = [jsonReponse["results"].array as! MoviePojo]
                }
            }
            
        }
        
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return moviesJsonList.count
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MovieCollectionViewCell
        
        cell.image.image=UIImage(named:"logo.png")
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
        return CGSize(width: (collectionView.bounds.size.width/2 - CGFloat(15)), height: CGFloat(kWhateverHeightYouWant - 63))
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieDetailsController : MovieDetailsViewController = storyboard?.instantiateViewController(withIdentifier: "MovieDetailsViewController") as! MovieDetailsViewController
        movieDetailsController.movie = moviesJsonList[indexPath.item];
        self.navigationController?.pushViewController(movieDetailsController, animated: true);
    }
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MovieDetails") as! MovieDetailsViewController
        nextViewController.modalTransitionStyle = .flipHorizontal
        self.navigationController?.pushViewController(nextViewController, animated: true)
//        self.present(nextViewController, animated:true, completion:nil)
     return true
     }
    
    
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

