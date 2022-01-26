//
//  GaleryView.swift
//  Movies
//
//  Created by Ty Pham on 19/01/2022.
//

import SwiftUI

struct GaleryView: View {
    
    @ObservedObject var viewModel: GaleryViewModel = GaleryViewModel()
    @State var isShowDetail: Bool = false
    
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 1) {
                Text("")
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment:.leading) {
                        ForEach(viewModel.genres){ genreViewModel in
                            GenreView(title: genreViewModel.title,
                                      items: genreViewModel.movies)
                                .frame(width: proxy.size.width, height: 300)
                        }
                    }
                }
            }
        }
    }
}

struct GaleryView_Previews: PreviewProvider {
    static var previews: some View {
        GaleryView()
    }
}
