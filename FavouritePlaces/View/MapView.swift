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
    /// to make map non-movable for non-edicmode
    @State private var _isLoading: Bool = true
    @State var mapMoving: Bool = true

    var body: some View {
        VStack{
            /// if it's in edit mode
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
                        lookupCoordinatesCoreData()
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
                                latitude = ""
                            }
                        }
                        ///  if you are quit from edit mode, the changed values will be updated to coredata
                        ///  It will also change the value of mapMoving so user can't move their map in Non-edit mode
                        .onDisappear()
                        {
                            updateMapValuesToCoreData()
                            mapMoving = true
                            
                        }
                        /// if you are in edit mode, you can move your map
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
    
    ///<#Description#>
    /// if user press look up coordinates button, the updated values from CLLocation will updates changed values to place(Coredata) and region(Map)
    func lookupCoordinatesCoreData(){
        $place.placeLatitude.wrappedValue = location.latitudeString
        $place.placeLongitude.wrappedValue = location.longitudeString
        $region.latitudeString.wrappedValue = location.latitudeString
        $region.longitudeString.wrappedValue = location.longitudeString
    }
    /// <#Description#>
    /// if you changes the latitude and longitude from edit mode then quit the mode, the changed values will be updated in coredata and CLLocation
    func updateMapValuesToCoreData(){
        $place.placeLatitude.wrappedValue = region.latitudeString
        $place.placeLongitude.wrappedValue = region.longitudeString
        $place.placeName.wrappedValue = location.name
        $location.latitudeString.wrappedValue = region.latitudeString
        $location.longitudeString.wrappedValue = region.longitudeString
    }
    ///<#Description#>
    /// if user press the look up name function, the CLLocation's latitude and longitude will be updated to the changed latitude and longitude values from region(Map)
    /// so It will find the place name from changed values.
    func regionToLocation(){
        $location.latitudeString.wrappedValue = region.latitudeString
        $location.longitudeString.wrappedValue = region.longitudeString
    }

    /// <#Description#>
    /// LookupName function from CLLocation takes some time to present the result. In order to match the speed. it will hold it for 0.5 to process it.
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
