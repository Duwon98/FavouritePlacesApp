//
//  FavouritePlaces+CoreDataProperties.swift
//  FavouritePlaces
//
//  Created by Duwon Ha on 14/5/2022.
//
//

import Foundation
import CoreData


extension FavouritePlaces {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavouritePlaces> {
        return NSFetchRequest<FavouritePlaces>(entityName: "FavouritePlaces")
    }

    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var name: String?
    @NSManaged public var note: String?
    @NSManaged public var url: String?

}

extension FavouritePlaces : Identifiable {

}
