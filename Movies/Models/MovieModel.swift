//
//  MovieModel.swift
//  Movies
//
//  Created by Ty Pham on 19/01/2022.
//

import Foundation

struct MovieModel: Identifiable, Codable {
    var id: String
    var title: String
    var backdrop: String
    var cast:[String]
    var classification: String
    var genres: [String]
    var imdbRating: Float
    var length: String
    var overview: String
    var poster: String
    var releasedOn: Date
    var slug: String
    var director: [String]
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case backdrop
        case cast
        case classification
        case genres
        case length
        case overview
        case poster
        case slug
        case imdbRating = "imdb_rating"
        case releasedOn = "released_on"
        case director = "director"
    }
    
    init(){
        id = ""
        title = ""
        backdrop = ""
        poster = ""
        cast = []
        director = []
        genres = []
        imdbRating = 0
        classification = ""
        slug = ""
        releasedOn = Date()
        overview = ""
        length = ""
    }
    
    init(entity: MovieEntity){
        id = entity.idString ?? ""
        title = entity.title ?? ""
        backdrop = entity.backdrop ?? ""
        poster = entity.poster ?? ""
        cast = entity.casts ?? []
        director = entity.directors ?? []
        genres = entity.genres ?? []
        imdbRating = entity.imdp
        classification = entity.classification ?? ""
        slug = entity.slug ?? ""
        releasedOn = entity.releaseOn ?? Date()
        overview = entity.overview ?? ""
        length = entity.length ?? ""
    }
}

extension MovieModel {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        backdrop = try container.decode(String.self, forKey: .backdrop)
        cast = try container.decode([String].self, forKey: .cast)
        classification = try container.decode(String.self, forKey: .classification)
        length = try container.decode(String.self, forKey: .length)
        genres = try container.decode([String].self, forKey: .genres)
        imdbRating = try container.decode(Float.self, forKey: .imdbRating)
        poster = try container.decode(String.self, forKey: .poster)
        slug = try container.decode(String.self, forKey: .slug)
        overview = try container.decode(String.self, forKey: .overview)
        
        let dateString = try container.decode(String.self, forKey: .releasedOn)
        let formatter = DateFormatter.iso8601Full
        if let date = formatter.date(from: dateString) {
            releasedOn = date
        } else {
            throw DecodingError.dataCorruptedError(forKey: .releasedOn, in: container, debugDescription: "Parse error")
        }
        
        //json sometimes return array or a string
        director = []
        do {
            let aDirector = try container.decode(String.self, forKey: .director)
            director = [aDirector]
        }catch {
            print(error)
        }
        
        do {
            director = try container.decode([String].self, forKey: .director)
        }catch {
            print(error)
        }
    }
}

struct MoviesListModel: Codable {
    var movies:[MovieModel]?
}

