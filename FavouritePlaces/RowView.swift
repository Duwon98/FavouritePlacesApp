//
//  RowView.swift
//  FavouritePlaces
//
//  Created by Duwon Ha on 2/5/2022.
//

import SwiftUI

struct RowView: View {
    @ObservedObject var place: Place
    @Environment(\.managedObjectContext) var viewContext
    
    var body: some View {

//        AsyncImage(url: URL(string: place.url ?? "")) { image in
//            image.resizable()
//        } placeholder: {
//            Image(systemName: "photo")
//        }
//        .frame(width: 40, height: 40)
//        .clipShape(RoundedRectangle(cornerRadius: 25))
        
        NavigationLink("\(place.name ?? "" )"){
            DetailView(place: place)
        }

    }

//struct RowView_Previews: PreviewProvider {
//    static var previews: some View {
//        RowView()
//    }

}

//        NavigationLink(
//            """
//            \(Image(systemName: "photo").data(url: URL(string: place.url ?? "defult")!)
//            )
//            """
//            , destination: DetailView(place: place))
