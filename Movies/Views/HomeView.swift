//
//  HomeView.swift
//  Movies
//
//  Created by Ty Pham on 19/01/2022.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedTab: Int = 0
    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab) {
                GaleryView().tabItem {
                    Label("Home", systemImage: "house")
                }.tag(1)
                SearchView().tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }.tag(2)
                FavoriteMoviesView().tabItem {
                    Label("Favorite", systemImage: "heart.fill")
                }.tag(3)
            }
            .navigationBarTitle("Wookie Movies")
            .navigationBarTitleDisplayMode(.inline)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
