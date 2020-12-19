//
//  CategoryProductsEntity+CoreDataProperties.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/19/20.
//

import Foundation
import CoreData


extension CategoryProductsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryProductsEntity> {
        return NSFetchRequest<CategoryProductsEntity>(entityName: "CategoryProducts")
    }

    @NSManaged public var categoryId: String?
    @NSManaged public var products: Set<ProductEntity>?

}

// MARK: Generated accessors for products
extension CategoryProductsEntity {

    @objc(addProductsObject:)
    @NSManaged public func addToProducts(_ value: ProductEntity)

    @objc(removeProductsObject:)
    @NSManaged public func removeFromProducts(_ value: ProductEntity)

    @objc(addProducts:)
    @NSManaged public func addToProducts(_ values: Set<ProductEntity>)

    @objc(removeProducts:)
    @NSManaged public func removeFromProducts(_ values: Set<ProductEntity>)

}

extension CategoryProductsEntity : Identifiable {

}
