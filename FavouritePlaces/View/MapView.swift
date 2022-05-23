//
//  MapView.swift
//  FavouritePlaces
//
//  Created by Duwon Ha on 14/5/2022.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapView: View {
    @ObservedObject var place: FavouritePlaces
    @State var region: MKCoordinateRegion
    @ObservedObject var location: LocationViewModel
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.editMode) var mode
    @State var latitude = ""
    @State var longtitude = ""

    var body: some View {
        VStack{
            
            if self.mode?.wrappedValue.isEditing ?? true{
                HStack{
                    Button{
                        $location.latitudeString.wrappedValue = region.latitudeString
                        $location.longitudeString.wrappedValue = region.longitudeString
                        location.lookupName(for: location.location)
                        /// need timer here
                        $place.placeName.wrappedValue = location.name
                        

                    } label: {
                        Label("", systemImage: "text.magnifyingglass" )
                    }
                    TextField("", text: $location.name){
                        $place.placeName.wrappedValue = location.name
                        location.lookupCoordinates(for: location.name)
                        
                        //need timer here
//                        updateMapValuesToCoreData()
                        
                    }
                }

            }
            
            Map(coordinateRegion: $region)
            /// if you are in edit mode
            if self.mode?.wrappedValue.isEditing ?? true  {
                HStack{
                    Button{
                        
                        location.lookupCoordinates(for: location.name)
                        //timer
                        latitude = location.latitudeString
                        longtitude = location.longitudeString
                        updateMapValuesToCoreData()
                        latitude = ""
                        longtitude = ""
                        
                        
                    } label: {
                        Label("", systemImage: "globe.europe.africa.fill" )
                    }
                    VStack{
                        HStack{
                            Text("Lat: ")
                            TextField((region.latitudeString), text: $latitude)
                            {
                                $region.latitudeString.wrappedValue = latitude
                                updateMapValuesToCoreData()
                                latitude = ""
                            }
                        }
                        ///  if you are quit from edit mode, the changed values will be updated to coredata
                        .onDisappear()
                        {
                            updateMapValuesToCoreData()
                        }
                        
                        HStack{
                            Text("Lon: ")
                            TextField((region.longitudeString), text: $longtitude)
                            {
                                $region.longitudeString.wrappedValue = longtitude
                                updateMapValuesToCoreData()
                                longtitude = ""
                            }
                        }
                    }

                }

            }
            
            /// if you are not in edit mode
            else  {
                HStack{
                    Text("Latitude: \(region.latitudeString) ")
                }
                /// You can not change the Latitude and Longitude in non-Edit-Mode
                ///  the values from map will be back to original values from Core data
                .onDisappear()
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
    
    /// <#Description#>
    /// if you changes the latitude and longitude from edit mode then quit the mode, the changed values will be updated in coredata
    func updateMapValuesToCoreData(){
        $place.placeLatitude.wrappedValue = region.latitudeString
        $place.placeLongitude.wrappedValue = region.longitudeString
        $place.placeName.wrappedValue = location.name
        $region.latitudeString.wrappedValue = location.latitudeString
        $region.longitudeString.wrappedValue = location.longitudeString
    }
    
    /// <#Description#>
    /// you can't change the values in non-edit-mode.
    /// when you move the map from the view, the values is changing but once you quit the page the orginal values will be updated again.
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
