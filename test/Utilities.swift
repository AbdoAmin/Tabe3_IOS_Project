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

    static public func getTrailerList(fromJson json:JSON)->[Trailer]{
        var trailers:[Trailer]=[]
        for (_,trailer):(String, JSON) in json {
            let temp:Trailer=Trailer()
            for (key,value):(String, JSON) in trailer {
                switch key{
                case "name":
                    temp.name=value.string;
                    break
                case "key":
                    temp.key=value.string;
                    break
                case "site":
                    temp.site=value.string;
                    break
                default:
                    break
                }
            }
            trailers.append(temp)
        }
        return trailers
    }
    static public func getReviewList(fromJson json:JSON)->[Review]{
        var reviews:[Review]=[]
        for (_,review):(String, JSON) in json {
            let temp:Review=Review()
            for (key,value):(String, JSON) in review {
                switch key{
                case "author":
                    temp.author=value.string;
                    break
                case "content":
                    temp.content=value.string;
                    break
                default:
                    break
                }
            }
            reviews.append(temp)
        }
        return reviews
    }
}
