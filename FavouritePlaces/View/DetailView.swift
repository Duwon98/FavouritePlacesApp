//
//  DetailView.swift
//  FavouritePlaces
//
//  Created by Duwon Ha on 2/5/2022.
//

import SwiftUI
import MapKit
import CoreLocation

struct DetailView: View {
    @ObservedObject var place: FavouritePlaces
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.editMode) var mode
    @StateObject var coordinates = LocationViewModel(location: CLLocation(latitude: 0, longitude: 0))
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
                  Map(coordinateRegion: $region)
                    .frame(width: 40, height: 40)
                    .disabled(true)
                NavigationLink("Map of \(place.placeName)"){
                    MapView(place: place, region: region)
                    }
                }
                Text(place.placeNote)
                    .padding()
                
                HStack{
                    Label(coordinates.sunrise , systemImage: "sunrise")
                    Spacer()
                    Label(coordinates.sunset, systemImage: "sunset")
                }

                

            }
        }
        .navigationTitle(place.placeName)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
                }
            }
        /// if DetailView is Appear the region values will be updated from core data
        .onAppear()
        {
            updateLocation()
        }
    }
    
    /// <#Description#>
    /// It will update the values of latitude and longitude from coredata to Map element
    func updateLocation(){
        $region.latitudeString.wrappedValue = place.placeLatitude
        $region.longitudeString.wrappedValue = place.placeLongitude
        $coordinates.latitudeString.wrappedValue = region.latitudeString
        $coordinates.longitudeString.wrappedValue = region.longitudeString
        $coordinates.name.wrappedValue = place.placeName
//        coordinates.lookupCoordinates(for: coordinates.name)
        coordinates.lookupName(for: coordinates.location)
    }
}

