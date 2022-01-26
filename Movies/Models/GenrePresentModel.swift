//
//  GenrePresentModel.swift
//  Movies
//
//  Created by Ty Pham on 20/01/2022.
//

import Foundation

struct GenrePresentModel: Identifiable {
    let id: UUID = UUID()
    let title: String
    let movies: [MovieModel]
}
