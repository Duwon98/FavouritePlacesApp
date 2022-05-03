//
//  FavouritePlaces+CoreDataProperties.swift
//  FavouritePlaces
//
//  Created by Duwon Ha on 3/5/2022.
//
//

import Foundation
import CoreData


extension FavouritePlaces {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavouritePlaces> {
        return NSFetchRequest<FavouritePlaces>(entityName: "FavouritePlaces")
    }

    @NSManaged public var name: String?
    @NSManaged public var places: NSOrderedSet?

}

// MARK: Generated accessors for places
extension FavouritePlaces {

    @objc(insertObject:inPlacesAtIndex:)
    @NSManaged public func insertIntoPlaces(_ value: Place, at idx: Int)

    @objc(removeObjectFromPlacesAtIndex:)
    @NSManaged public func removeFromPlaces(at idx: Int)

    @objc(insertPlaces:atIndexes:)
    @NSManaged public func insertIntoPlaces(_ values: [Place], at indexes: NSIndexSet)

    @objc(removePlacesAtIndexes:)
    @NSManaged public func removeFromPlaces(at indexes: NSIndexSet)

    @objc(replaceObjectInPlacesAtIndex:withObject:)
    @NSManaged public func replacePlaces(at idx: Int, with value: Place)

    @objc(replacePlacesAtIndexes:withPlaces:)
    @NSManaged public func replacePlaces(at indexes: NSIndexSet, with values: [Place])

    @objc(addPlacesObject:)
    @NSManaged public func addToPlaces(_ value: Place)

    @objc(removePlacesObject:)
    @NSManaged public func removeFromPlaces(_ value: Place)

    @objc(addPlaces:)
    @NSManaged public func addToPlaces(_ values: NSOrderedSet)

    @objc(removePlaces:)
    @NSManaged public func removeFromPlaces(_ values: NSOrderedSet)

}

extension FavouritePlaces : Identifiable {

}
