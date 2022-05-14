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
    @Environment(\.managedObjectContext) var viewContext


//    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))

    
    var body: some View {
        VStack{
            Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))))
            
            HStack{
                Text("Lat: ")
                TextField("Enter Latitude", text: $place.placeLatitude)
            }
            HStack{
                Text("Lon: ")
                TextField("Enter Longitude", text: $place.placeLongitude)
            }
        }
        
    }
}
//
//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView(place: place)
//    }
//}
