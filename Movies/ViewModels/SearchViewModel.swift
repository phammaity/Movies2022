//
//  SearchViewModel.swift
//  Movies
//
//  Created by Ty Pham on 20/01/2022.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {
    @Published var movies: [MovieModel] = []
    @Published var searchText = ""
    private var cancellableSet: Set<AnyCancellable> = []
    private var serviceManager: NetworkServiceProtocol
    
    init(serviceManager: NetworkServiceProtocol = NetworkService.shared){
        self.serviceManager = serviceManager
        //handle search when text search change
        $searchText
            .dropFirst(1)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink {[weak self] text in
                if text.isEmpty {
                    self?.movies.removeAll()
                } else {
                    self?.searchMovies(queryString: text.trimmingCharacters(in: .whitespaces))
                }
            }.store(in: &cancellableSet)
    }
    
    private func searchMovies(queryString: String) {
        serviceManager.searchMovies(queryString: queryString)
            .sink {[weak self] (response) in
                if let _ = response.error {
                    self?.showAlert()
                }else {
                    self?.responseHandler(movies: response.value)
                }
            }
            .store(in: &cancellableSet)
    }
    
    private func showAlert() {
        //TODO: show error alert
    }
    
    private func responseHandler(movies: MoviesListModel?){
        //TODO: handle response data
        guard let movieListModel = movies else {
            return
        }
        
        self.movies = movieListModel.movies ?? []
    }
}
