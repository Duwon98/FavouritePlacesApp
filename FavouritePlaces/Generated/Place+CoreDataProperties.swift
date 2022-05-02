//
//  Place+CoreDataProperties.swift
//  FavouritePlaces
//
//  Created by Duwon Ha on 2/5/2022.
//
//

import Foundation
import CoreData


extension Place {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Place> {
        return NSFetchRequest<Place>(entityName: "Place")
    }

    @NSManaged public var location: String?
    @NSManaged public var name: String?
    @NSManaged public var note: String?
    @NSManaged public var url: String?
    @NSManaged public var favouritePlaces: FavouritePlaces?

}

extension Place : Identifiable {

}
