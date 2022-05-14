//
//  DetailView.swift
//  FavouritePlaces
//
//  Created by Duwon Ha on 2/5/2022.
//

import SwiftUI
import MapKit

struct DetailView: View {
    @ObservedObject var place: FavouritePlaces
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.editMode) var mode
    @State var latitude = ""
    @State var longtitude = ""

    var body: some View {
        List{
            /// If it's edit mode
            if self.mode?.wrappedValue.isEditing ?? true  {
                /// User can modify the TextField
                TextField((place.placeName), text: $place.placeName)
                /// User can modify the URL
                TextField(("Enter Image URL"), text: $place.placeURL )

                Text("Enter Location Details: ")
                    .font(.system(size: 17, weight: .heavy, design: .default))
                    .frame(maxWidth: .infinity, alignment: .center)
                /// User can modify the Detail of the place
                TextField(("Note"), text: $place.placeNote)
//                HStack{
//                    /// In order to optimise with  Automatic completion(with decimal point), Different method is implemented for editing Latitude and Longtitude
//                    Text("Latitude: ")
//                    TextField((place.placeLatitude), text: $latitude)
//                    {
//                        $place.placeLatitude.wrappedValue = latitude
//                    }
//                }
//                HStack{
//                    /// In order to optimise with  Automatic completion(with decimal point), Different method is implemented for editing Latitude and Longtitude
//                    Text("Longitude: ")
//                    TextField((place.placeLongitude), text: $longtitude)
//                    {
//                        $place.placeLongitude.wrappedValue = longtitude
//                    }
//                }
            }
            /// If it's not in edit mode
            else{
                /// Just displaying the values
                AsyncImage(url: URL(string: place.placeURL)) { image in
                    image.resizable()
                } placeholder: {
                    Image(systemName: "photo")
                }
                .frame(width: 260, height: 200)
                NavigationLink("Map of \(place.placeName)"){
                    MapView(place: place)}
                
                Text(place.placeNote)
//                Text("Latitude: " + place.placeLatitude)
//                Text("Longitude: " + place.placeLongitude)
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

