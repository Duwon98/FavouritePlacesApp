//
//  CLLocationViewModel.swift
//  FavouritePlaces
//
//  Created by Duwon Ha on 22/5/2022.
//

import Combine
import CoreLocation
import MapKit

class LocationViewModel: ObservableObject{
    @Published var location: CLLocation
    @Published var sunriseSunset = SunriseSunset(sunrise: "unknown", sunset: "unknown")
    @Published var name = ""
    
    
    
    var sunrise: String{
        get{ sunriseSunset.sunrise}
        set{ sunriseSunset.sunrise = newValue}
    }
    
    var sunset: String{
        get{ sunriseSunset.sunset}
        set{ sunriseSunset.sunset = newValue}
    }
    
    init(location: CLLocation){
        self.location = location
    }
    
    var latitudeString:String {
        get { "\(location.coordinate.latitude)" }
        set{
            guard let newLatitude = Double(newValue), -90 <= abs(newLatitude), abs(newLatitude) <= 90 else {return}
            let newLocation = CLLocation(latitude: newLatitude, longitude: location.coordinate.longitude)
            location = newLocation
        }
    }
    
    
    var longitudeString: String{
        get { "\(location.coordinate.longitude)" }
        set {
            guard let newLongitude = Double(newValue), -180 <= abs(newLongitude), abs(newLongitude) <= 180 else {return}
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
//                print(String(describing: placemark[keyPath: value]))
            }
            self.name = placemark.name ?? placemark.subAdministrativeArea ?? placemark.locality ?? placemark.subLocality ??
            placemark.thoroughfare ?? placemark.subThoroughfare ?? placemark.country ?? ""
            
        }
    }
    
    func lookupSunriseAndSunset(){
        let urlString = "https://api.sunrise-sunset.org/json?lat=\(latitudeString)&lng=\(longitudeString)"
        guard let url = URL(string: urlString) else{
            print("Malformed URL: \(urlString)")
            return
        }
        guard let jsonData = try? Data(contentsOf: url) else{
            print("Could not look up sunrise or sunset")
            return
        }
        guard let api = try? JSONDecoder().decode(SunriseSUnsetAPI.self, from: jsonData) else{
            print("Could not decode Json API:\n\(String(data: jsonData, encoding: .utf8) ?? "<empty>" )")
            return
        }
        let inputFormatter = DateFormatter()
        inputFormatter.dateStyle = .none
        inputFormatter.timeStyle = .medium
        inputFormatter.timeZone = .init(secondsFromGMT: 0)
        let outputFormatter = DateFormatter()
        outputFormatter.dateStyle = .none
        outputFormatter.timeStyle = .medium
        outputFormatter.timeZone = .current
        var converted = api.results
        
        if let time = inputFormatter.date(from: api.results.sunrise){
            converted.sunrise = outputFormatter.string(from: time)
        }
        if let time = inputFormatter.date(from: api.results.sunset){
            converted.sunset = outputFormatter.string(from: time)
        }
            sunriseSunset = converted
    }
}
