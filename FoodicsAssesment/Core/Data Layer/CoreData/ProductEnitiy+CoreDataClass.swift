//
//  ProductEnitiy+CoreDataClass.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/19/20.
//

import Foundation
import CoreData

@objc(ProductEntity)
public class ProductEntity: NSManagedObject {
    func toProductModel() -> ProductModel{
        ProductModel(productEntity: self)
    }

}

