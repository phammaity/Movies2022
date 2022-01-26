//
//  MovieItemView.swift
//  Movies
//
//  Created by Ty Pham on 19/01/2022.
//

import SwiftUI

struct MovieItemView: View {
    let url : String

    var body: some View {
        ZStack {
            CacheAsyncImage(
                url: URL(string: url)!
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
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .background(RoundedRectangle(cornerRadius: 20).stroke(Color.white, lineWidth: 2))
        .contentShape(Rectangle())
    }
}

struct MovieItemView_Previews: PreviewProvider {
    static var previews: some View {
        MovieItemView(url: "https://wookie.codesubmit.io/static/posters/f3d91837-a2ff-4250-99b0-e8c9c036a23a.jpg")
    }
}
