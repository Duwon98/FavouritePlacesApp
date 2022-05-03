//
//  DetailView.swift
//  FavouritePlaces
//
//  Created by Duwon Ha on 2/5/2022.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var place: Place
    @Environment(\.managedObjectContext) var viewContext
    
    var body: some View {
        VStack{
            Text(place.url ?? "Defult")
            TextField((place.name ?? "Defult"), text:Binding(get: {place.name ?? ""}, set: {place.name = $0}),
                onCommit: {
                do {
                    try viewContext.save()
                } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            })
        }.navigationTitle(place.name ?? "Defult")
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
