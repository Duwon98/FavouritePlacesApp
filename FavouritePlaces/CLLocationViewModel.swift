//
//  CLLocationViewModel.swift
//  FavouritePlaces
//
//  Created by Duwon Ha on 22/5/2022.
//

import Combine
import CoreLocation

class LocationViewModel: ObservableObject{
    @Published var location: CLLocation
    @Published var name = ""
    
    init(location: CLLocation){
        self.location = location
    }
    
    var latitudeString:String {
        get {" \(location.coordinate.latitude)" }
        set{
            guard let newLatitude = Double(newValue) else {return}
            let newLocation = CLLocation(latitude: newLatitude, longitude: location.coordinate.longitude)
            location = newLocation
        }
    }
    
    var longitudeString: String{
        get { "\(location.coordinate.longitude)" }
        set {
            guard let newLongitude = Double(newValue) else {return}
            let newLocation = CLLocation(latitude: location.coordinate.latitude, longitude: newLongitude)
            location = newLocation
        }
    }
    
    func lookupCoordinates(for place: String){
        let coder = CLGeocoder()
        coder.geocodeAddressString(place) { optionalplacemarks, optionalError in
            if let error = optionalError {
                print("Error looking up \(place): \(error.localizedDescription)")
                return
            }
            guard let placemarks = optionalplacemarks, !placemarks.isEmpty else{
                print("Placemarks came back empty")
                return
            }
            let placemark = placemarks[0]
            guard let location = placemark.location else{
                print("Placemark has no location")
                return
            }
            self.location = location
        }
    }
    
    func lookupName(for location: CLLocation){
        let coder = CLGeocoder()
        coder.reverseGeocodeLocation(location) { optionalplacemarks, optionalError in
            if let error = optionalError {
                print("Error looking up \(location.coordinate): \(error.localizedDescription)")
                return
            }
            guard let placemarks = optionalplacemarks, !placemarks.isEmpty else{
                print("Placemarks came back empty")
                return
            }
            let placemark = placemarks[0]
            for value in [
                \CLPlacemark.name,
                \.country,
                \.isoCountryCode,
                \.postalCode,
                \.administrativeArea,
                \.subAdministrativeArea,
                \.locality,
                \.subLocality,
                \.thoroughfare,
                \.subThoroughfare
            ]{
                print(String(describing: placemark[keyPath: value]))
            }
            self.name = placemark.name ?? placemark.subAdministrativeArea ?? placemark.locality ?? placemark.subLocality ??
            placemark.thoroughfare ?? placemark.subThoroughfare ?? placemark.country ?? ""
        }
    }
}
