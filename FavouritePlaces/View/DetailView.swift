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
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
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
                
                HStack{
//                  Map(coordinateRegion: $region)
//                    .frame(width: 40, height: 40)
                NavigationLink("Map of \(place.placeName)"){
                    MapView(place: place, region: region)
                    }
                }
                Text(place.placeNote)

            }
        }
        .navigationTitle(place.placeName)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
                }
            }
        .onAppear()
        {
        updateLocation()
            print("This is value from DetailView Lat: \(place.placeLatitude) Long: \(place.placeLongitude) " )
        }
    }
    
    
    func updateLocation(){
        $region.latitudeString.wrappedValue = place.placeLatitude
        $region.longitudeString.wrappedValue = place.placeLongitude
    }
}

