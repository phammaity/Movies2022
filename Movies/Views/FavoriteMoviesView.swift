//
//  FavoriteMoviesView.swift
//  Movies
//
//  Created by Ty Pham on 21/01/2022.
//

import SwiftUI

struct FavoriteMoviesView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var viewModel: FavoriteMoviesViewModel = FavoriteMoviesViewModel()
    let spacing: CGFloat = 16
    
    var body: some View {
        GeometryReader { proxy in
            let colums = [GridItem(.fixed(proxy.size.width/2 - spacing*2), spacing: spacing),
                         GridItem(.fixed(proxy.size.width/2 - spacing*2), spacing: spacing)]
            VStack(spacing: 1) {
                Text("")
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
        .onAppear(perform: {
            self.viewModel.fetchData(viewContext: viewContext)
        })
    }
}

struct FavoriteMoviesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteMoviesView()
    }
}
