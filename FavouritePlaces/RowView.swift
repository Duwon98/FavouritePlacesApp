//
//  RowView.swift
//  FavouritePlaces
//
//  Created by Duwon Ha on 2/5/2022.
//

import SwiftUI

struct RowView: View {
    @ObservedObject var place: FavouritePlaces
    @Environment(\.managedObjectContext) var viewContext
    
    var body: some View {
        HStack{
        AsyncImage(url: URL(string: place.url ?? "")) { image in
            image.resizable()
        } placeholder: {
            Image(systemName: "photo")
        }
        .frame(width: 40, height: 40)
        
            NavigationLink("\(place.placeName)"){
            DetailView(place: place)
            }
        }
    }
}
