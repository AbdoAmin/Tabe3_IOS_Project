//
//  Utilities.swift
//  test
//
//  Created by ashraf on 4/4/19.
//  Copyright © 2019 com.AbdoAmin. All rights reserved.
//

import Foundation
import SwiftyJSON

class Utilities {
    static public func getMovieList(fromJson json:JSON)->[Movie]{
        var movies:[Movie]=[]
        for (_,movie):(String, JSON) in json {
            let temp:Movie=Movie()
            for (key,value):(String, JSON) in movie {
                switch key{
                case "id":
                    temp.id=value.int;
                    break
                case "title":
                    temp.title=value.string;
                    break
                case "overview":
                    temp.overview=value.string;
                    break
                case "poster_path":
                    temp.image=value.string;
                    break
                case "vote_average":
                    temp.rating=value.float;
                    break
                case "release_date":
                    temp.releaseYear=value.string;
                    break
                case "genre_ids":
                    temp.genres=value.arrayObject as? Array<String>;
                    break
                default:
                    break
                }
            }
            movies.append(temp)
        }
        return movies
    }
    
//    static public func getTrailerList(fromJson json:JSON)->[Trailer]{
//        var trailers:[Trailer]=[]
//        for (_,movie):(String, JSON) in json {
//            let temp:Trailer=Trailer()
//            for (key,value):(String, JSON) in movie {
//                switch key{
//                case "id":
//                    temp.id=value.int;
//                    break
//                case "title":
//                    temp.title=value.string;
//                    break
//                case "image":
//                    temp.image=value.string;
//                    break
//                case "rating":
//                    temp.rating=value.float;
//                    break
//                case "releaseYear":
//                    temp.releaseYear=value.string;
//                    break
//                case "genres":
//                    temp.genres=value.arrayObject as? Array<String>;
//                    break
//                default:
//                    break
//                }
//            }
//            movies.append(temp)
//        }
//        return movies
//    }
//    static public func getReviewList(fromJson json:JSON)->[Review]{
//        var reviews:[Review]=[]
//        for (_,review):(String, JSON) in json {
//            let temp:Review=Review()
//            for (key,value):(String, JSON) in movie {
//                switch key{
//                case "id":
//                    temp.id=value.int;
//                    break
//                case "title":
//                    temp.title=value.string;
//                    break
//                case "image":
//                    temp.image=value.string;
//                    break
//                case "rating":
//                    temp.rating=value.float;
//                    break
//                case "releaseYear":
//                    temp.releaseYear=value.string;
//                    break
//                case "genres":
//                    temp.genres=value.arrayObject as? Array<String>;
//                    break
//                default:
//                    break
//                }
//            }
//            movies.append(temp)
//        }
//        return movies
//    }
}
