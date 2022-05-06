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
