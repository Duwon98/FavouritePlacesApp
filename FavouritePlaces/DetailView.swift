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
    @Environment(\.editMode) var mode
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 3
        return formatter
    }()

    
    var body: some View {
        List{
            /// if it's edit mode
            if self.mode?.wrappedValue.isEditing ?? true  {
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
                
                TextField(("Enter Image URL"), text:Binding(get: {place.url ?? ""}, set: {place.url = $0}),
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
                
                Text("Enter Location Details: ")
                    .font(.system(size: 17, weight: .heavy, design: .default))
                    .frame(maxWidth: .infinity, alignment: .center)
                
                TextField((place.note ?? ""), text:Binding(get: {place.note ?? ""}, set: {place.note = $0}),
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
                HStack{
                    Text("Latitude: ")
                    TextField((String(place.latitude)), value: $place.latitude, formatter: formatter, onCommit: {
                        do {
                            try viewContext.save()
                        } catch {
                            // Replace this implementation with code to handle the error appropriately.
                            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                            let nsError = error as NSError
                            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                        }
                    })
                }
                
                HStack{
                    Text("Longitude: ")
                    TextField((String(place.longitude)), value: $place.longitude, formatter: formatter, onCommit: {
                        do {
                            try viewContext.save()
                        } catch {
                            // Replace this implementation with code to handle the error appropriately.
                            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                            let nsError = error as NSError
                            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                        }
                    })
                }
                
            }
            else{
                AsyncImage(url: URL(string: place.url ?? "")) { image in
                    image.resizable()
                } placeholder: {
                    Image(systemName: "photo")
                }
                .frame(width: 260, height: 200)
                Text(place.note ?? " ")
                Text("Latitude: " + String(place.latitude))
                Text("Longitude: " + String(place.longitude))
            }
        }
        .navigationTitle(place.name ?? "Defult")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
                }
            }
        }
    }

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
