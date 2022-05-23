//
//  CoordinateRegionViewModel.swift
//  FavouritePlaces
//
//  Created by Duwon Ha on 14/5/2022.
//

import Foundation
import MapKit
import CoreLocation

extension MKCoordinateRegion{
    var latitudeString: String {
        get{ "\(center.latitude)" }
        set{
            guard let degrees = CLLocationDegrees(newValue), -90 <= abs(degrees), abs(degrees) <= 90 else {return}
            center.latitude = degrees
            
        }
    }
    
    var longitudeString: String {
        get{ "\(center.longitude)" }
        set{
            guard let degrees = CLLocationDegrees(newValue), -180 <= abs(degrees), abs(degrees) <= 180 else {return}
            center.longitude = degrees
        }
    }
}

