//
//  FavouritePlaces+CoreDataProperties.swift
//  FavouritePlaces
//
//  Created by Duwon Ha on 6/5/2022.
//
//

import Foundation
import CoreData


extension FavouritePlaces {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavouritePlaces> {
        return NSFetchRequest<FavouritePlaces>(entityName: "FavouritePlaces")
    }

    @NSManaged public var latitude: Float
    @NSManaged public var longitude: Float
    @NSManaged public var name: String?
    @NSManaged public var note: String?
    @NSManaged public var url: String?

}

extension FavouritePlaces : Identifiable {

}
