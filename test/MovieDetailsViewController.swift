//
//  MovieDetailsViewController.swift
//  test
//
//  Created by ashraf on 4/1/19.
//  Copyright © 2019 com.AbdoAmin. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import SwiftyJSON
import Cosmos
import DOButton
class MovieDetailsViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{
    var movieDao: MovieDao = MovieDao()
    @IBOutlet weak var reviewLable: UILabel!
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet weak var trailerTable: UITableView!
    @IBOutlet var movieImage: UIImageView!
    @IBOutlet weak var favoriteBtn: DOButton!
    @IBOutlet weak var movieOverviewLAble: UILabel!

    @IBOutlet weak var movieRate: CosmosView!
    @IBOutlet weak var scrollView: UIScrollView!
    var movie : Movie!
    var movieList:Array<String> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        favoriteBtn.imageColorOff = UIColor.brown
        favoriteBtn.imageColorOn = UIColor.red
        favoriteBtn.circleColor = UIColor.green
        favoriteBtn.lineColor = UIColor.blue
        favoriteBtn.duration = 3.0

//        favoriteBtn.addTarget(self, action: #selector(self.tapped(_:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(favoriteBtn)
        // default: 1.0
        movieRate.settings.fillMode = .precise

        movieRate.rating=Double(movie.rating!)
        trailerTable.delegate=self
        trailerTable.dataSource=self
        movieTitleLabel.text=movie.title!
        movieOverviewLAble.text=movie.overview!
        movieImage.sd_setImage(with: URL(string: AppConstants.IMAGE_URL+self.movie.image!), placeholderImage: UIImage(named: "logo.png"))
        let trailerUrl =  AppConstants.BASE_URL + "movie/" + String(describing: movie.id!) + "/videos?api_key=" + AppConstants.API_KEY
        let reviewUrl =  AppConstants.BASE_URL + "movie/" + String(describing: movie.id!) + "/reviews?api_key=" + AppConstants.API_KEY
       fetchTrailersAndReviews(trailerUrl: trailerUrl,reviewUrl:reviewUrl)
        // Do any additional setup after loading the view.
    }
    func tapped(sender: DOButton) {

    }
    func fetchTrailersAndReviews(trailerUrl tUrl: String,reviewUrl rUrl: String)  {

        DispatchQueue.main.async {
            Alamofire.request(tUrl).responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    self.movie.trailers = Utilities.getTrailerList(fromJson: json["results"]);
                    self.trailerTable.reloadData()

                case .failure(let error):
                    print(error)
                }
            }
            Alamofire.request(rUrl).responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    self.movie.reviews = Utilities.getReviewList(fromJson: json["results"]);
                    for review in self.movie.reviews!{
                        self.reviewLable.text?.append(review.author!+"\n")
                        self.reviewLable.text?.append(review.content!+"\n")
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return movie.trailers?.count ?? 0

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrailerCell", for: indexPath) as! MovieTrailersTableCell
//         cell.textLabel?.text = String(describing: movieList[indexPath.row])
        cell.trailerNameLabel?.text = movie.trailers?[indexPath.row].name!
        cell.trailerImage.image = UIImage(named:"logo.png")
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//             let detailsView : DetailsViewController = storyboard?.instantiateViewController(withIdentifier: "DetailsVC") as! DetailsViewController
//        let youtubeURL = NSURL(string:"https://www.youtube.com/watch?v=\(movieList[indexPath.row])")
        let youtubeURL = URL(string:"https://www.youtube.com/watch?v="+(movie.trailers?[indexPath.row].key!)!)
        if(UIApplication.shared.canOpenURL(youtubeURL!)){
            UIApplication.shared.openURL(youtubeURL!)
        }
    }
    @IBAction func addToDatabaseBtn(_ sender: Any) {
//        if (sender as AnyObject).isSelected {
//            // deselect
//            (sender as AnyObject).deselect()
//        } else {
//            // select with animation
//            (sender as AnyObject).select()
//        }
        movieDao.saveMovie(movie: movie)
      movieDao.fetchMovies()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
