//
//  ContentView.swift
//  FavouritePlaces
//
//  Created by Duwon Ha on 1/5/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    /// viewContext
    @Environment(\.managedObjectContext) private var viewContext
    /// Sorting the data by Name (Ascending order)
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \FavouritePlaces.name, ascending: true)],
        animation: .default)
    /// Fetching the data
    private var favPlaces: FetchedResults<FavouritePlaces>


var body: some View {
    NavigationView{
        List {
            /// looping the favPlaces
            ForEach(favPlaces) { place in
                RowView(place: place)
            }
            .onDelete(perform: deleteItems)
        }
        .navigationTitle("Favourite Places")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: addItem) {
                    Label("Add Item", systemImage: "plus")
                    }
                }
            }
    }.onAppear(){
        /// Checking if coredata is empty
        if favPlaces.isEmpty{
            loadDefaultData()
        }
    }
    }
    /// <#Description#>
    /// This function will allow users to add a Favourite Place
    /// It will add the defult name of the place (New Place) But User can  change the name in DetailView
    private func addItem() {
        withAnimation {
            let newPlace = FavouritePlaces(context: viewContext)
            /// New Place will be listed at the end of the list. It is made for user's convinience.
            let lastAsci = String(UnicodeScalar(UInt8(127)))
            newPlace.name = "\(lastAsci)New place"
            /// if Save cause the error it will print error massage rather than stop the application
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    /// <#Description#>
    /// This function will allow users to delete a Favourite Place
    /// - Parameters:
    ///     - offsets : <# IndexSet #>
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { favPlaces[$0] }.forEach(viewContext.delete)
            /// if Save cause the error it will print error massage rather than stop the application
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    /// <#Description#>
    /// This function will be called if the coredata is empty. It will generate the default data.
    private func loadDefaultData() {
        let defaultPlace = FavouritePlaces(context: viewContext)
        defaultPlace.name = "Busan"
        defaultPlace.latitude = 35.16
        defaultPlace.longitude = 129.14
        defaultPlace.placeNote = "This is my hometown Haeundae"
        defaultPlace.placeURL = "https://www.lottehotelmagazine.com/resources/d434c17f-5ac2-4b98-8021-f3bdd5cc26f4_img_TRAVEL_busan_detail01.jpg"
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
        let defaultPlace2 = FavouritePlaces(context: viewContext)
        defaultPlace2.name = "Gold Coast"
        defaultPlace2.latitude = -28
        defaultPlace2.longitude = 153.42
        defaultPlace2.placeNote = "This is Surfers Paradise"
        defaultPlace2.placeURL = "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/17/27/77/5b/photo0jpg.jpg?w=1200&h=1200&s=1"
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
        let defaultPlace3 = FavouritePlaces(context: viewContext)
        defaultPlace3.name = "Paris"
        defaultPlace3.latitude = 48.8
        defaultPlace3.longitude = 2.29
        defaultPlace3.placeNote = "This is Eiffel Tower!"
        defaultPlace3.placeURL = "https://www.mycity24.com.au/mycityko/pad_img/72100_1.jpg"
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
    
