//
//  SearchView.swift
//  Movies
//
//  Created by Ty Pham on 19/01/2022.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: SearchViewModel = SearchViewModel()
    let spacing: CGFloat = 16
    
    var body: some View {
        GeometryReader { proxy in
            let colums = [GridItem(.fixed(proxy.size.width/2 - spacing*2), spacing: spacing),
                         GridItem(.fixed(proxy.size.width/2 - spacing*2), spacing: spacing)]
            VStack {
                SearchBar(searchText: $viewModel.searchText)
                Spacer(minLength: 0)
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(
                        columns: colums,
                        alignment: .center,
                        spacing: spacing
                    ) {
                        ForEach(viewModel.movies) { movie in
                            NavigationLink(destination: MovieDetailView(movieModel: movie)) {
                                MovieItemView(url: movie.poster)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
