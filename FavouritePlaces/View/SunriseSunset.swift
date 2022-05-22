//
//  SunriseSunset.swift
//  FavouritePlaces
//
//  Created by Duwon Ha on 23/5/2022.
//

import Foundation

struct SunriseSunset: Codable{
    var sunrise: String
    var sunset: String
}

struct SunriseSUnsetAPI: Codable{
    var results: SunriseSunset
    var status: String?
}
