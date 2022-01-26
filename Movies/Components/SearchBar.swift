//
//  SearchBar.swift
//  Movies
//
//  Created by Ty Pham on 20/01/2022.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("Search movies", text: $searchText)
        }
        .foregroundColor(.gray)
        .padding(.leading, 13)
        .frame(height: 40)
        .background(RoundedRectangle(cornerRadius: 4).strokeBorder(Color.gray))
        .padding()
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(searchText: .constant("search text"))
    }
}
