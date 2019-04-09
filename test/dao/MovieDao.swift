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
    var fetchedMovies : Array<Movie> = []
    func saveMovie(movie : Movie) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;

        let managedContext = appDelegate.managedObjectContext;
        if(isMovieExists(movieTitle: movie.title!, appDelegate: appDelegate)){
        let entity = NSEntityDescription.entity(forEntityName: "MovieEntity", in: managedContext);
        //let trailerEntity = NSEntityDescription.entity(forEntityName: "TrailerEntity", in: managedContext);
        let  movieTrailersToString = Utilities.parseTrailerToString(fromList: movie.trailers!)
        let  movieReviewsToString = Utilities.parseReviewToString(fromList: movie.reviews!)
     
//        let storedtrailer = NSManagedObject(entity: trailerEntity!, insertInto: managedContext);
        let storedMovie = NSManagedObject(entity: entity!, insertInto: managedContext);
    
        storedMovie.setValue(movie.id, forKey:"id");
        storedMovie.setValue(movie.title, forKey:"title");
        storedMovie.setValue(movie.popularity, forKey:"popularity");
        storedMovie.setValue(movie.rating, forKey:"rate");
        storedMovie.setValue(movie.overview, forKey:"overview");
        storedMovie.setValue(movie.releaseYear , forKey:"releaseYear");
        storedMovie.setValue(movie.image, forKey:"image");
        storedMovie.setValue(movieTrailersToString, forKey: "trailers")
        storedMovie.setValue(movieReviewsToString, forKey: "reviews")

        do {
        try managedContext.save()
        } catch {
            print("Failed saving")
            }}
    }
    func fetchMovies()-> Array<Movie>{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        let managedContext = appDelegate.managedObjectContext;
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieEntity")
        request.relationshipKeyPathsForPrefetching = ["trailers"]
        //request.predicate = NSPredicate(format: "age = %@", "12")
    request.returnsObjectsAsFaults = false
        do {
            let result = try managedContext.fetch(request)
            
            for data in result as! [NSManagedObject] {
                let movie = Movie()
                movie.id = data.value(forKey: "id") as! Int
                movie.title = data.value(forKey: "title") as! String
                movie.overview = data.value(forKey: "overview") as! String
                movie.image = data.value(forKey: "image") as! String
                movie.releaseYear = data.value(forKey: "releaseYear") as! String
                movie.rating = data.value(forKey: "rate") as! Float
                movie.popularity = data.value(forKey: "popularity") as! Float
                movie.trailers = Utilities.parseTrailerToList(fromString: data.value(forKey: "trailers") as! String)
                movie.reviews = Utilities.parseReviewToList(fromString: data.value(forKey: "reviews") as! String)
                fetchedMovies.append(movie)
            }
            
        } catch {
            
            print("Failed")
        }
        return fetchedMovies
    }
    
    func deleteData(movieId :Int){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieEntity")
        fetchRequest.predicate = NSPredicate(format: "id = %@", movieId)
        
        do
        {
            let test = try managedContext.fetch(fetchRequest)
            
            let objectToDelete = test[0] as! NSManagedObject
            managedContext.delete(objectToDelete)
            
            do{
                try managedContext.save()
            }
            catch
            {
                print(error)
            }
            
        }
        catch
        {
            print(error)
        }
    }
    func isMovieExists(movieTitle: String,appDelegate :AppDelegate) -> Bool {
        var fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MovieEntity")
        fetchRequest.predicate = NSPredicate(format: "title= %d", movieTitle)
        
        var results: [NSManagedObject] = []
        
        do {
            results = try appDelegate.managedObjectContext.fetch(fetchRequest)
        }
        catch {
            print("error executing fetch request: \(error)")
        }
        
        return results.count > 0
    }

}
