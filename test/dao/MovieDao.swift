//
//  MovieDao.swift
//  test
//
//  Created by ashraf on 4/4/19.
//  Copyright © 2019 com.AbdoAmin. All rights reserved.
//

import UIKit
import CoreData
class MovieDao {
    func savescore(movie : MoviePojo) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        let managedContext = appDelegate.managedObjectContext;
        let entity = NSEntityDescription.entity(forEntityName: "Movie", in: managedContext);
        //let movie = NSManagedObject(entity: entity!, insertInto: managedContext);
        let storedMovie = NSManagedObject(entity: entity!, insertInto: managedContext);
        
        storedMovie.setValue(movie.title, forKey:"title");
        storedMovie.setValue(movie.rating, forKey:"rating");
        storedMovie.setValue(movie.releaseYear as? Int, forKey:"releaseYear");
        storedMovie.setValue(movie.poster_path as? String, forKey:"image");
        storedMovie.setValue(movie.genres as? String, forKey:"genre");
        
    }
}
