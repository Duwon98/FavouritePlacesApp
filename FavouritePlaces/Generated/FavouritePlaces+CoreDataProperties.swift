//
//  FavouritePlaces+CoreDataProperties.swift
//  FavouritePlaces
//
//  Created by Duwon Ha on 1/5/2022.
//
//

import Foundation
import CoreData


extension FavouritePlaces {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavouritePlaces> {
        return NSFetchRequest<FavouritePlaces>(entityName: "FavouritePlaces")
    }

    @NSManaged public var name: String?
    @NSManaged public var places: NSSet?

}

// MARK: Generated accessors for places
extension FavouritePlaces {

    @objc(addPlacesObject:)
    @NSManaged public func addToPlaces(_ value: Place)

    @objc(removePlacesObject:)
    @NSManaged public func removeFromPlaces(_ value: Place)

    @objc(addPlaces:)
    @NSManaged public func addToPlaces(_ values: NSSet)

    @objc(removePlaces:)
    @NSManaged public func removeFromPlaces(_ values: NSSet)

}

extension FavouritePlaces : Identifiable {

}
