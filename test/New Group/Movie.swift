//
//  Movie.swift
//  test
//
//  Created by ashraf on 4/1/19.
//  Copyright © 2019 com.AbdoAmin. All rights reserved.
//

import Foundation

class Movie:Codable{
    var id : Int?
    var title : String?
    var image : String?
    var rating : Float?
    var releaseYear : String?
    var genres : Array<String>?
    var trailers: Array<String>  = []

}
