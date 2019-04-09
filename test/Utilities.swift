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
                    // temp.genres=value.arrayObject as? Array<String>;
                    break
                case "popularity":
                    temp.popularity=value.float;
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
    
    static public func parseReviewToList(fromString str:String)->[Review]{
        var reviewList:[Review]=[]
        let objectList=str.components(separatedBy: ";:;")
        for object in objectList{
            if !object.isEmpty{
                let temp:Review=Review()
                let attribute=object.components(separatedBy: ":;:")
                temp.author=attribute[0]
                temp.content=attribute[1]
                reviewList.append(temp)
            }
        }
        return reviewList
    }
    static public func parseReviewToString(fromList rList:[Review])->String{
        var parsedList:String=""
        for review in rList{
            parsedList+=review.author!
            parsedList+=":;:"
            parsedList+=review.content!
            parsedList+=";:;"
        }
        if !parsedList.isEmpty{
            parsedList.removeLast()
            parsedList.removeLast()
            parsedList.removeLast()
        }
        return parsedList
    }
    static public func parseTrailerToList(fromString str:String)->[Trailer]{
        var trailerList:[Trailer]=[]
        let objectList=str.components(separatedBy: ";:;")
        for object in objectList{
            if !object.isEmpty{
                let temp:Trailer=Trailer()
                let attribute=object.components(separatedBy: ":;:")
                temp.key=attribute[0]
                temp.name=attribute[1]
                temp.site=attribute[2]
                trailerList.append(temp)
            }
        }
        return trailerList
    }
    static public func parseTrailerToString(fromList rList:[Trailer])->String{
        var parsedList:String=""
        for trailer in rList{
            parsedList+=trailer.key!
            parsedList+=":;:"
            parsedList+=trailer.name!
            parsedList+=":;:"
            parsedList+=trailer.site!
            parsedList+=";:;"
        }
        if !parsedList.isEmpty{
            parsedList.removeLast()
            parsedList.removeLast()
            parsedList.removeLast()
        }
        return parsedList
    }
}
