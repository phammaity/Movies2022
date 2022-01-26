//
//  MovieDetailView.swift
//  Movies
//
//  Created by Ty Pham on 20/01/2022.
//

import SwiftUI

struct MovieDetailView: View {
    let spacer: CGFloat = 20
    let posterHeight: CGFloat = 120
    let backdropHeight: CGFloat = 300
    
    @ObservedObject var viewModel: MovieDetailViewModel
    @Environment(\.managedObjectContext) private var viewContext
    
    init(movieModel: MovieModel){
        self.viewModel = MovieDetailViewModel(movieModel: movieModel)
    }
    
    var body: some View {
        GeometryReader { geometryProxy in
            ScrollView {
                VStack {
                    ZStack(alignment:.bottomLeading) {
                        backdropView
                            .frame(width: geometryProxy.size.width, height: backdropHeight)
                        HStack(spacing: 8) {
                            MovieItemView(url: viewModel.poster)
                                .frame(width: posterHeight - 20, height: posterHeight)
                            VStack(alignment: .leading) {
                                titleView
                                Spacer(minLength: 0)
                                ratingView
                            }.padding(.vertical, 5)
                        }
                        .frame(width: geometryProxy.size.width - 2 * spacer, height: posterHeight, alignment: .leading)
                        .padding(.horizontal, spacer)
                        .offset(x: 0, y: posterHeight/2)
                    }
                    .padding(.bottom, posterHeight/2)
                    contentView.padding()
                }
            }.edgesIgnoringSafeArea(.top)
        }
        .onAppear(perform: {
            self.viewModel.fetchMovieEntity(viewContext: viewContext)
        })
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                likeButton
            }
        }
    }
    
    var likeButton: some View {
        Button {
            viewModel.updateFavoriteMovie(viewContext: viewContext)
        } label: {
            Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
                .foregroundColor(Color.blue)
                .padding()
        }
        .disabled(viewModel.isProcessing)
        .frame(width: 44, height: 44, alignment: .center)
    }
    
    var contentView: some View {
        VStack(alignment:.leading, spacing: 20) {
            Text(viewModel.yearAndLengthText)
                .font(.headline)
            Text(viewModel.casts)
                .font(.headline)
                .foregroundColor(Color.blue)
            Text(viewModel.overview)
        }.multilineTextAlignment(.leading)
    }
    
    
    var backdropView: some View {
        CacheAsyncImage(
            url: URL(string: viewModel.backdrop)!
        ) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            default:
                Color.gray
            }
        }
    }
    
    var titleView: some View {
        Text(viewModel.title)
            .font(.headline)
            .multilineTextAlignment(.leading)
            .foregroundColor(Color.white)
    }
    
    var ratingView: some View {
        HStack {
            ForEach(0..<viewModel.stars.count, id:\.self){index in
                return Image(systemName: viewModel.stars[index]).foregroundColor(Color.yellow)
            }
        }
    }
    
}
