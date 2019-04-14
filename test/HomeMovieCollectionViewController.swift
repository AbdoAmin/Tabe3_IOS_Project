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
    static var firstVisit=true
    var pageNumber=0;
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        view.backgroundColor = UIColor.white
        let my_switch = UISwitch(frame: .zero)
        my_switch.isOn = true // or false
        let switch_display = UIBarButtonItem(customView: my_switch)
        navigationItem.rightBarButtonItem = switch_display
        
    }
    override func viewWillAppear(_ animated: Bool) {
        if self.restorationIdentifier == "fivoriteCollectionView" {
            self.navigationController?.setNavigationBarHidden(true, animated: false)
            Spinner.start()
            let dao = MovieDao()
            DispatchQueue.main.async {
                self.moviesJsonList = dao.fetchMovies()
                Spinner.stop()
                self.collectionView?.reloadData()
            }
        }
        else{
            if HomeMovieCollectionViewController.firstVisit{
                HomeMovieCollectionViewController.firstVisit=false
                refreshTo(mode: true,pageNumber:pageNumber)
                
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
        cell.image.sd_setImage(with: URL(string: AppConstants.IMAGE_URL+self.moviesJsonList[indexPath.row].image!), placeholderImage: UIImage(named: "logo.png"))
        //        cell.layer.borderColor = UIColor.yellow.cgColor
        //        cell.layer.borderWidth = 1
        cell.layer.cornerRadius=15
        
        return cell
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
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if self.restorationIdentifier != "fivoriteCollectionView" {
            if (indexPath.row == moviesJsonList.count - 1 ) {
                refreshTo(mode: true,pageNumber:pageNumber)
            }
        }
    }
    
    
    
    var closuer :((DataResponse<Any>) -> Void)!
    
    func refreshTo(mode:Bool,pageNumber pNum:Int){
        closuer={ (response :DataResponse<Any>) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if pNum==0 {
                    self.pageNumber+=1
                    self.moviesJsonList=Utilities.getMovieList(fromJson: json["results"]);
                }
                else if pNum > 0 && self.moviesJsonList.count <= (pNum)*20{
                    self.pageNumber+=1
                    self.moviesJsonList+=Utilities.getMovieList(fromJson: json["results"]);
                }
                Spinner.stop()
                self.collectionView?.reloadData()
            case .failure(let error):
                print(error)
            }
        }
        Spinner.start()
        
        
        if mode {
            DispatchQueue.main.async {
                Alamofire.request(AppConstants.BASE_URL+"movie/top_rated?page="+String(pNum+1)+"&api_key="+AppConstants.API_KEY).responseJSON(completionHandler: self.closuer)
            }
        }
        else{
            DispatchQueue.main.async {
                Alamofire.request(AppConstants.BASE_URL+"movie/popular?page="+String(pNum+1)+"&api_key="+AppConstants.API_KEY).responseJSON(completionHandler: self.closuer)
            }
        }
        
    }
    
    
    
}
