//
//  FavouritePlaces+ViewModel.swift
//  FavouritePlaces
//
//  Created by Duwon Ha on 2/5/2022.
//

import Foundation

extension FavouritePlaces{
    /// Non-optional ViewModel property for (optional)  'name' datavase attribute'
    var placeName: String {
        get {name ?? ""}
        set {
            name = newValue
            save()
        }
    }
    
    var placeURL: String {
        get {url ?? ""}
        set {
            url = newValue
            save()
        }
    }
    
    var placeNote: String {
        get {note ?? ""}
        set {
            note = newValue
            save()
        }
    }
    
    var placeLatitude: String {
        get { String(latitude)}
        set {
            guard let lat = Float(newValue) else {return}
            latitude = lat
            save()
        }
    }
    
    var placeLongitude: String {
        get { String(longitude)}
        set {
            guard let lat = Float(newValue) else {return}
            longitude = lat
            save()
        }
    }
    
    /// you don't get warning from non-Checking
    @discardableResult
    func save() -> Bool {
        do {
            try managedObjectContext?.save()
        } catch{
            print("Error saving: \(error)")
            return false
        }
        return true
    }

}
