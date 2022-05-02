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
        Text("Hello")
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
