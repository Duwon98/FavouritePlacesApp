//
//  MapView.swift
//  FavouritePlaces
//
//  Created by Duwon Ha on 14/5/2022.
//

import SwiftUI
import MapKit

struct MapView: View {
    @ObservedObject var place: FavouritePlaces
    @State var region: MKCoordinateRegion
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.editMode) var mode
    @State var latitude = ""
    @State var longtitude = ""

    var body: some View {
        VStack{
            Map(coordinateRegion: $region)
            
            if self.mode?.wrappedValue.isEditing ?? true  {
                HStack{
                    Text("Lat: ")
                    TextField("Enter Longitude", text: $region.latitudeString)
                }
//                .onDisappear()
//                {
//                    updateMapValuesToCoreData()
//                    print("This is values from the Map Lat: \(region.latitudeString) Long: \(region.longitudeString)")
//                }
                
                HStack{
                    Text("Lon: ")
                    TextField("Enter Longitude", text: $region.longitudeString)
                }
            }
            
//            HStack{
//                Text("Lat: ")
//                TextField((regison.latitudeString), text: $latitude )
//                {
//                    $regison.latitudeString.wrappedValue = latitude
//                }
//
//            }
            
            else  {
                HStack{
                    Text("Latitude: \(region.latitudeString) ")
                }
                
                HStack{
                    Text("Latitude: \(region.longitudeString) ")
                }
                
                
            }
        }.navigationTitle(place.placeName)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                    }
                }
            .onDisappear(){
                updateMapValuesToCoreData()
            }
        
    }
    
    func updateMapValuesToCoreData(){
        $place.placeLatitude.wrappedValue = region.latitudeString
        $place.placeLongitude.wrappedValue = region.longitudeString
        
    }
}
//
//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView(place: place)
//    }
//}
