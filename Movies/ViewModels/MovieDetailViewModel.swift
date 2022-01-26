//
//  MovieDetailViewModel.swift
//  Movies
//
//  Created by Ty Pham on 20/01/2022.
//

import Foundation
import CoreData

class MovieDetailViewModel: ObservableObject {
    private let movieModel: MovieModel
    private var movieEntity: MovieEntity?
    
    @Published var isFavorite: Bool = false
    @Published var isProcessing: Bool = false
    
    var stars: [String] = []
    
    init(movieModel: MovieModel){
        self.movieModel = movieModel
        self.stars = self.starImagesGenerate(point: movieModel.imdbRating)
    }
    
    var overview: String {
        return self.movieModel.overview
    }
    
    var title: String {
        return String(format: "%@(%.1f)",self.movieModel.title, self.ratingPoint)
    }
    
    var poster: String {
        return self.movieModel.poster
    }
    
    var backdrop: String {
        return self.movieModel.backdrop
    }
    
    var ratingPoint: Float{
        return self.movieModel.imdbRating
    }
    
    var yearAndLengthText: String {
        return String(format: "%d | %@ | %@", self.movieModel.releasedOn.get(.year), self.movieModel.length, self.directors)
    }
    
    var directors: String {
        return self.movieModel.director.joined(separator: ", ")
    }
    
    var casts: String {
        return "Cast: " + self.movieModel.cast.joined(separator: ", ")
    }
    
    func starImagesGenerate(point: Float) -> [String] {
        //imdb is in [1 ... 10], stars is in [1 ... 5] => point/2
        let numberOfStars = point/2.0
        let fullstars = Int(numberOfStars)
        var imageArray: [String] = []
        
        //get filled stars
        imageArray = (0..<fullstars).map({ _ in
            return "star.fill"
        })
        
        //get a half filled star
        if (numberOfStars - Float(fullstars)) != 0.0 {
            imageArray.append("star.leadinghalf.filled")
        }
        
        //get remain empty stars
        if imageArray.count < 5 {
            let unFillStars = (0..<(5 - imageArray.count)).map { index in
                return "star"
            }
            imageArray += unFillStars
        }
        
        return imageArray
    }
    
    func fetchMovieEntity(viewContext: NSManagedObjectContext) {
        let request: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        let predicate = NSPredicate(format: "idString == %@", self.movieModel.id as CVarArg)
        request.predicate = predicate
        do {
            let result = try viewContext.fetch(request)
            self.movieEntity = result.first
            self.isFavorite = movieEntity != nil
        } catch {
            print("no object")
        }
    }
    
    func updateFavoriteMovie(viewContext: NSManagedObjectContext){
        self.isProcessing = true
        if isFavorite {
            removeFavorite(viewContext: viewContext)
            
        }else {
            addFavorite(viewContext: viewContext)
        }
        
        isFavorite.toggle()
        //prevent many tapping
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {[weak self] in
            self?.isProcessing = false
        }
    }
    
    func removeFavorite(viewContext: NSManagedObjectContext) {
        if let entity = movieEntity {
            do {
                viewContext.delete(entity)
                try viewContext.save()
                movieEntity = nil
                
                print("SAVED")
            } catch {
                print("no object")
            }
        }
    }
    
    func addFavorite(viewContext: NSManagedObjectContext) {
        let entity = MovieEntity(context: viewContext)
        entity.idString = movieModel.id
        entity.title = movieModel.title
        entity.overview = movieModel.overview
        entity.genres = movieModel.genres
        entity.casts = movieModel.cast
        entity.directors = movieModel.director
        entity.classification = movieModel.classification
        entity.releaseOn = movieModel.releasedOn
        entity.imdp = movieModel.imdbRating
        entity.slug = movieModel.slug
        entity.length = movieModel.length
        entity.backdrop = movieModel.backdrop
        entity.poster = movieModel.poster
        do {
            try viewContext.save()
        }catch {
            print("can not save")
        }
    }
}
