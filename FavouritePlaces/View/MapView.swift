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
    @State private var _isLoading: Bool = true
    @State var mapMoving: Bool = true

    var body: some View {
        VStack{
            
            if self.mode?.wrappedValue.isEditing ?? true{
                HStack{
                    Button{
                        regionToLocation()
                        location.lookupName(for: location.location)
                        loadingCall()

                    } label: {
                        Label("", systemImage: "text.magnifyingglass" )
                    }
                    TextField("", text: $location.name){
                        $place.placeName.wrappedValue = location.name
                        location.lookupCoordinates(for: location.name)
                        
                    }
                }

            }
            
            Map(coordinateRegion: $region)
                .disabled(mapMoving)
            /// if you are in edit mode
            if self.mode?.wrappedValue.isEditing ?? true  {
                
                HStack{
                    Button{
                        location.lookupCoordinates(for: location.name)
                        latitude = location.latitudeString
                        longtitude = location.longitudeString
                        coreDataLookupName()
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
//                                updateMapValuesToCoreData()
                                latitude = ""
                            }
                        }
                        ///  if you are quit from edit mode, the changed values will be updated to coredata
                        .onDisappear()
                        {
                            updateMapValuesToCoreData()
                            
                        }
                        .onAppear()
                        {
                            mapMoving = false
                        }
                        
                        HStack{
                            Text("Lon: ")
                            TextField((region.longitudeString), text: $longtitude)
                            {
                                $region.longitudeString.wrappedValue = longtitude
//                                updateMapValuesToCoreData()
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
                .onAppear()
                {
                    mapMoving = true
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
    func coreDataLookupName(){
        $place.placeLatitude.wrappedValue = location.latitudeString
        $place.placeLongitude.wrappedValue = location.longitudeString
        $region.latitudeString.wrappedValue = location.latitudeString
        $region.longitudeString.wrappedValue = location.longitudeString

    }
    func updateMapValuesToCoreData(){
        $place.placeLatitude.wrappedValue = region.latitudeString
        $place.placeLongitude.wrappedValue = region.longitudeString
        $place.placeName.wrappedValue = location.name
        $location.latitudeString.wrappedValue = region.latitudeString
        $location.longitudeString.wrappedValue = region.longitudeString
    }
    
    func regionToLocation(){
        $location.latitudeString.wrappedValue = region.latitudeString
        $location.longitudeString.wrappedValue = region.longitudeString
    }
    
    /// <#Description#>
    /// you can't change the values in non-edit-mode.
    /// when you move the map from the view, the values is changing but once you quit the page the orginal values will be updated again.
    func reverseToOriginalLocation(){
        $region.latitudeString.wrappedValue = place.placeLatitude
        $region.longitudeString.wrappedValue = place.placeLongitude
    }

    func loadingCall(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            $place.placeName.wrappedValue = location.name
        }
            }
    

}
//
//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView(place: place)
//    }
//}
