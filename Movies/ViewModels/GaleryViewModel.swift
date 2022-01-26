//
//  GaleryViewModel.swift
//  Movies
//
//  Created by Ty Pham on 20/01/2022.
//

import Foundation
import Combine

class GaleryViewModel: ObservableObject {
    @Published var genres: [GenrePresentModel] = []
    
    private var cancellableSet: Set<AnyCancellable> = []
    private var serviceManager: NetworkServiceProtocol
    
    init(serviceManager: NetworkServiceProtocol = NetworkService.shared){
        self.serviceManager = serviceManager
        fetchMovies()
    }
    
    private func fetchMovies() {
        serviceManager.fetchMovies()
            .sink {[weak self] (response) in
                if let _ = response.error {
                    self?.showAlert()
                }else {
                    self?.responseHandler(movies: response.value)
                }
            }
            .store(in: &cancellableSet)
    }
    
    private func responseHandler(movies: MoviesListModel?){
        //TODO: handle response data
        guard let movieListModel = movies else {
            return
        }
        
        //craete dictionary key = genres, value = list of movies
        var movieByGenresDic: [String : [MovieModel]] = [:]
        
        movieListModel.movies?.forEach { movieModel in
            movieModel.genres.forEach { genre in
                if let value = movieByGenresDic[genre] {
                    //movies array existed with key "genre"
                    movieByGenresDic[genre] = value + [movieModel]
                }else {
                    //movies array not init yet with key "genre"
                    movieByGenresDic[genre] = [movieModel]
                }
            }
        }
        
        // generate GenrePresentModel
        self.genres = movieByGenresDic.map({ (genre, movies) in
            return GenrePresentModel(title: genre, movies: movies)
        })
    }
    
    private func showAlert() {
        //TODO: show error alert
    }
    
}
