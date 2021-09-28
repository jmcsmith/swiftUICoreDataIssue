//
//  Favorite+CoreDataProperties.swift
//  swiftUICoreDataIssue
//
//  Created by Joe Smith on 9/28/21.
//
//

import Foundation
import CoreData


extension Favorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite")
    }

    @NSManaged public var name: String?
    @NSManaged public var person: Person?

}

extension Favorite : Identifiable {

}
