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
}
    
