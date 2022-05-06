//
//  DetailView.swift
//  FavouritePlaces
//
//  Created by Duwon Ha on 2/5/2022.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var place: FavouritePlaces
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.editMode) var mode
    @State var latitude = ""
    @State var longtitude = ""
//    let formatter: NumberFormatter = {
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .decimal
//        formatter.maximumFractionDigits = 3
//        return formatter
//    }()
    

    
    var body: some View {
        List{
            /// if it's edit mode
            if self.mode?.wrappedValue.isEditing ?? true  {
                TextField((place.placeName), text: $place.placeName)
                
                TextField(("Enter Image URL"), text: $place.placeURL )
                
                Text("Enter Location Details: ")
                    .font(.system(size: 17, weight: .heavy, design: .default))
                    .frame(maxWidth: .infinity, alignment: .center)
                
                TextField(("Note"), text: $place.placeNote)
                HStack{
                    Text("Latitude: ")
                    TextField((place.placeLatitude), text: $latitude)
                    {
                        $place.placeLatitude.wrappedValue = latitude
                    }
                }
                HStack{
                    Text("Longitude: ")
                    TextField((place.placeLongitude), text: $longtitude)
                    {
                        $place.placeLongitude.wrappedValue = longtitude
                    }
                }
            }
            else{
                AsyncImage(url: URL(string: place.placeURL)) { image in
                    image.resizable()
                } placeholder: {
                    Image(systemName: "photo")
                }
                .frame(width: 260, height: 200)
                Text(place.placeNote)
                Text("Latitude: " + place.placeLatitude)
                Text("Longitude: " + place.placeLongitude)
            }
        }
        .navigationTitle(place.placeName)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
                }
            }
        }
    }

