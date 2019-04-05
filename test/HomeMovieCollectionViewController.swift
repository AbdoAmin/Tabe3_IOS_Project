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
    var moviesJsonList:Array<Movie> = []

    override func viewDidLoad() {
        super.viewDidLoad()
//        let fadeTextAnimation = CATransition()
//        fadeTextAnimation.duration = 0.5
//        fadeTextAnimation.type = kCATransitionFade
//        navigationController?.navigationBar.layer.add(fadeTextAnimation, forKey: "fadeText")
//            navigationItem.title = "test 123"
        DispatchQueue.main.async {
            Alamofire.request(AppConstants.BASE_URL+"movie/top_rated?api_key="+AppConstants.API_KEY).responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    self.moviesJsonList=Utilities.getMovieList(fromJson: json["results"]);
                    print(self.moviesJsonList[0].title!)
                    self.collectionView?.reloadData()
                case .failure(let error):
                    print(error)
                }
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
        cell.image.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w185"+self.moviesJsonList[indexPath.row].image!), placeholderImage: UIImage(named: "logo.png"))
//        cell.layer.borderColor = UIColor.yellow.cgColor
//        cell.layer.borderWidth = 1
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
        movieDetailsController.modalTransitionStyle = .crossDissolve
        self.navigationController?.pushViewController(movieDetailsController, animated: true);
    }
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
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

