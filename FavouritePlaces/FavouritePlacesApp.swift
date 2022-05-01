//
//  FavouritePlacesApp.swift
//  FavouritePlaces
//
//  Created by Duwon Ha on 1/5/2022.
//

import SwiftUI

@main
struct FavouritePlacesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
