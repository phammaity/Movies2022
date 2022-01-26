//
//  MoviesApp.swift
//  Movies
//
//  Created by Ty Pham on 19/01/2022.
//

import SwiftUI

@main
struct MoviesApp: App {
    var body: some Scene {
        WindowGroup {
            AppRootView()
                .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
        }
    }
}
