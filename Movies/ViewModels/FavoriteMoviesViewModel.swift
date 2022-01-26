//
//  FavoriteMoviesViewModel.swift
//  Movies
//
//  Created by Ty Pham on 21/01/2022.
//

import Foundation
import CoreData

class FavoriteMoviesViewModel: ObservableObject {
    
    @Published var movies: [MovieModel] = []
    
    func fetchData(viewContext: NSManagedObjectContext) {
        let request: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        do {
            let entities = try viewContext.fetch(request)
            self.movies = entities.map({ entity in
                return MovieModel(entity: entity)
            })
        } catch {
            print("fetch request failed, managedobject")
        }
    }
}
