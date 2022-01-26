//
//  NetworkService.swift
//  Movies
//
//  Created by Ty Pham on 19/01/2022.
//

import Foundation
import Combine
import Alamofire

protocol NetworkServiceProtocol {
    func fetchMovies() -> AnyPublisher<DataResponse<MoviesListModel, NetworkError>, Never>
    func searchMovies(queryString: String) -> AnyPublisher<DataResponse<MoviesListModel, NetworkError>, Never>
}

class NetworkService: NetworkServiceProtocol {
    static let shared: NetworkServiceProtocol = NetworkService()
    private let urlString = "https://wookie.codesubmit.io/movies"
    private let token = "Wookie2019"
    private init() { }

    func fetchMovies() -> AnyPublisher<DataResponse<MoviesListModel, NetworkError>, Never> {
        return fetchData(urlString: urlString)
    }
    
    func searchMovies(queryString: String) -> AnyPublisher<DataResponse<MoviesListModel, NetworkError>, Never> {
        let validQuery = queryString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        let queryStringUrl = "\(urlString)?q=\(validQuery)"
        return fetchData(urlString: queryStringUrl)
    }
    
    func fetchData<T: Decodable>(urlString: String) -> AnyPublisher<DataResponse<T, NetworkError>, Never> {
        //create request url
        let url = URL(string: urlString)!
        
        //create header
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        return AF.request(url,method: .get, headers: headers)
            .validate()
            .publishDecodable(type: T.self)
            .map { response in
                response.mapError { error in
                    let systemError = response.data.flatMap {
                        try? JSONDecoder().decode(SystemError.self, from: $0)
                    }
                    return NetworkError(error: error, systemError: systemError)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
