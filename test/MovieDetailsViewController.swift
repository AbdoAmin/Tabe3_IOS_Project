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

class MovieDetailsViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{
    var movieDao: MovieDao = MovieDao()
    @IBOutlet weak var reviewLable: UILabel!
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet weak var trailerTable: UITableView!
    @IBOutlet var movieImage: UIImageView!

    var movie : Movie!
    var movieList:Array<String> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        trailerTable.delegate=self
        trailerTable.dataSource=self
        movieTitleLabel.text=movie.title!
        movieImage.sd_setImage(with: URL(string: AppConstants.IMAGE_URL+self.movie.image!), placeholderImage: UIImage(named: "logo.png"))
        let trailerUrl =  AppConstants.BASE_URL + "movie/" + String(describing: movie.id!) + "/videos?api_key=" + AppConstants.API_KEY
        let reviewUrl =  AppConstants.BASE_URL + "movie/" + String(describing: movie.id!) + "/reviews?api_key=" + AppConstants.API_KEY
       fetchTrailersAndReviews(trailerUrl: trailerUrl,reviewUrl:reviewUrl)
        // Do any additional setup after loading the view.
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
        movieDao.saveMovie(movie: movie)
        movieDao.fetchMovie(id: movie.id!)
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
