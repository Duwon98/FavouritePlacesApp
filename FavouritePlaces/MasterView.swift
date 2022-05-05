//
//  MasterView.swift
//  FavouritePlaces
//
//  Created by Duwon Ha on 3/5/2022.
//

import SwiftUI

struct MasterView: View {
    @ObservedObject var favPlaces : FavouritePlaces
    @Environment(\.managedObjectContext) var viewContext
    
    var body: some View {
        List {
            ForEach(favPlaces.placeArray) { place in
                RowView(place: place)
            }
            .onDelete(perform: deleteItems)
            .onMove(perform: move)
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
    
    private func addItem() {
        withAnimation {
            let place = Place(context: viewContext)
            place.name = "New Place"
            var places = favPlaces.placeArray
            places.append(place)
            favPlaces.places = NSOrderedSet(array: places)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { favPlaces.placeArray[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    func move(from source: IndexSet, to destination: Int) {
//        let itemToMove = source.first!
//
//        if itemToMove < destination {
//            var startIndex = itemToMove + 1
//            let endIndex = destination + 1
//            var startOrder = favPlaces.placeArray[itemToMove]
//        }
//        else if destination < itemToMove{
//
//        }
        


    }
    
    
}
