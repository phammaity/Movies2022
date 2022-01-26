//
//  GenreView.swift
//  Movies
//
//  Created by Ty Pham on 19/01/2022.
//

import SwiftUI

struct GenreView: View {
    let title: String
    let items: [MovieModel]
    var body: some View {
        GeometryReader { geometryProxy in
            VStack(alignment: .leading) {
                Text(title).padding(.leading)
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        ForEach(items){ item in
                            NavigationLink(destination: MovieDetailView(movieModel: item)) {
                                MovieItemView(url: item.poster).frame(minWidth: 150)
                            }
                        }
                    }.padding(.horizontal)
                }
            }
        }
    }
}
