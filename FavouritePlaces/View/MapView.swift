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
                    {
                        updateMapValuesToCoreData()
                    }
                }
                .onDisappear()
                {
                    updateMapValuesToCoreData()
                }
                
                HStack{
                    Text("Lon: ")
                    TextField("Enter Longitude", text: $region.longitudeString)
                    {
                        updateMapValuesToCoreData()
                    }
                }
            }
            
            
            else  {
                HStack{
                    Text("Latitude: \(region.latitudeString) ")
                }.onDisappear()
                {
                    reverseToOriginalLocation()
                }
                
                
                HStack{
                    Text("Longitude: \(region.longitudeString) ")
                }
                
                
            }
        }.navigationTitle(place.placeName)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                    }
                }

        
    }
    
    func updateMapValuesToCoreData(){
        $place.placeLatitude.wrappedValue = region.latitudeString
        $place.placeLongitude.wrappedValue = region.longitudeString
    }
    
    func reverseToOriginalLocation(){
        $region.latitudeString.wrappedValue = place.placeLatitude
        $region.longitudeString.wrappedValue = place.placeLongitude
    }
    

}
//
//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView(place: place)
//    }
//}
