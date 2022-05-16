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
            /// displaying the Image with Place name and detail of place
            AsyncImage(url: URL(string: place.placeURL)) { image in
            image.resizable()
                ///default photo
        } placeholder: {
            Image(systemName: "photo")
        }
        .frame(width: 40, height: 40)
            NavigationLink("\(place.placeName)\n"+"\(place.placeNote)"){
                DetailView(place: place)}
        }
    }
}
