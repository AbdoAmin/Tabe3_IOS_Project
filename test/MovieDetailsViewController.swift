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

class MovieDetailsViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{
    var movieDao: MovieDao = MovieDao()
    @IBOutlet var movieTitleLabel: UILabel!

  
    @IBOutlet var movieImage: UIImageView!
    var movie : Movie!
    var movieList:Array<String> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        var trailerUrl =  AppConstants.BASE_URL + "movie/" + String(describing: movie.id) + "/videos?api_key=" + AppConstants.API_KEY
        var reviewUrl =  AppConstants.BASE_URL + "movie/" + String(describing: movie.id) + "/videos?api_key=" + AppConstants.API_KEY

       // movie.trailers = fetchTrailersAndReviews(url: trailerUrl)
        // Do any additional setup after loading the view.
    }

    func fetchTrailersAndReviews(url: String) -> Array<String> {

        Alamofire.request(url).responseJSON { (response) in


        }
        return movieList
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 1

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrailerCell", for: indexPath)
        // cell.textLabel?.text = String(describing: movieList[indexPath.row])
       // cell.textLabel?.text = String(describing: movie.trailers[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //     let detailsView : DetailsViewController = storyboard?.instantiateViewController(withIdentifier: "DetailsVC") as! DetailsViewController
        //let youtubeURL = NSURL(string:"https://www.youtube.com/watch?v=\(movieList[indexPath.row])")
//        let youtubeURL = NSURL(string:"https://www.youtube.com/watch?v=\(movie.trailers[indexPath.row])")
//        if(UIApplication.shared.canOpenURL(youtubeURL as! URL)){
//            UIApplication.shared.openURL(youtubeURL as! URL)
//        }
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
