//
//  ContentView.swift
//  FavouritePlaces
//
//  Created by Duwon Ha on 1/5/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \FavouritePlaces.name, ascending: true)],
        animation: .default)
    private var favPlaces: FetchedResults<FavouritePlaces>

    var body: some View {
        NavigationView {
            MasterView(favPlaces: favPlaces.first ?? FavouritePlaces(context: viewContext))
        }
    }


}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}


