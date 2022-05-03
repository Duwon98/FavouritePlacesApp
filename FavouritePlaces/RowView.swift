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
        NavigationLink(
            "\(Image("https://en.wikipedia.org/wiki/File:Sydney_Australia._(21339175489).jpg")) \(place.name ?? "No name")", destination: DetailView(place: place))
    }

//struct RowView_Previews: PreviewProvider {
//    static var previews: some View {
//        RowView()
//    }
}

