//
//  CategoryEntity+CoreDataProperties.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/19/20.
//

import Foundation
import CoreData


extension CategoryEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryEntity> {
        return NSFetchRequest<CategoryEntity>(entityName: "Category")
    }

    @NSManaged public var id: String?
    @NSManaged public var imageURL: String?
    @NSManaged public var name: String?

}

extension CategoryEntity : Identifiable {

}
