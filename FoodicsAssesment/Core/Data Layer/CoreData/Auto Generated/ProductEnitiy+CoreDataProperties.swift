//
//  ProductEnitiy+CoreDataProperties.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/19/20.
//

import Foundation
import CoreData
extension ProductEntity {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductEntity> {
        return NSFetchRequest<ProductEntity>(entityName: "Product")
    }
    
    @NSManaged public var id: String?
    @NSManaged public var imageURL: String?
    @NSManaged public var name: String?
    @NSManaged public var price: Double
    @NSManaged public var categoryId: String?
    
}

extension ProductEntity : Identifiable {
    
}
