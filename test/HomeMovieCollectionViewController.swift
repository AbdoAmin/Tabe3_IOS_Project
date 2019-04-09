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
import Dropdowns

private let reuseIdentifier = "movieCell"

class HomeMovieCollectionViewController: UICollectionViewController ,UICollectionViewDelegateFlowLayout{
    var moviesJsonList:Array<Movie> = []
    let color = UIColor(red: 22/255, green: 160/255, blue: 33/255, alpha: 1)
    var mode=true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        let my_switch = UISwitch(frame: .zero)
        my_switch.isOn = true // or false
        my_switch.addTarget(self, action: #selector(switchToggled(_:)), for: .valueChanged)
        let switch_display = UIBarButtonItem(customView: my_switch)
        navigationItem.rightBarButtonItem = switch_display
        
        //        navigationController?.navigationBar.isTranslucent = false
        //        navigationController?.navigationBar.barTintColor = color
//        let items = ["World", "Sports", "Culture", "Business", "Travel"]
//        let titleView = TitleView(navigationController: navigationController!, title: "Menu", items: items)
//        titleView?.layoutSubviews()
//        titleView?.action = { index in
//            print("select \(index)")
//        }
//
//        navigationItem.titleView = titleView
//        Config.List.DefaultCell.Text.color = UIColor.red
        
        //        let fadeTextAnimation = CATransition()
        //        fadeTextAnimation.duration = 0.5
        //        fadeTextAnimation.type = kCATransitionFade
        //        navigationController?.navigationBar.layer.add(fadeTextAnimation, forKey: "fadeText")
        //            navigationItem.title = "test 123"
        if self.restorationIdentifier == "fivoriteCollectionView" {
            let dao = MovieDao()
            self.moviesJsonList = dao.fetchMovies()
            self.collectionView?.reloadData()
        }
        else{
            refreshTo(mode: mode)
        }
    }
    @objc func switchToggled(_ sender: UISwitch) {
        if sender.isOn {
            print( "The switch is now true!" )
        }
        else{
            print( "The switch is now false!" )
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
        cell.image.sd_setImage(with: URL(string: AppConstants.IMAGE_URL+self.moviesJsonList[indexPath.row].image!), placeholderImage: UIImage(named: "logo.png"))
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
        movieDetailsController.modalTransitionStyle = .flipHorizontal
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
    
    func refreshTo(mode:Bool){
        print("fdwefewfewfewf")
        self.mode=mode
        if mode {
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
        else{
            DispatchQueue.main.async {
                Alamofire.request(AppConstants.BASE_URL+"movie/popular?api_key="+AppConstants.API_KEY).responseJSON { (response) in
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
    }
    
}
