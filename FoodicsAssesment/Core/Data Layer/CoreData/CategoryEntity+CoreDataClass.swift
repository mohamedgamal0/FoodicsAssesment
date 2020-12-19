//
//  CategoryEntity+CoreDataClass.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/19/20.
//

import Foundation
import CoreData

@objc(CategoryEntity)
public class CategoryEntity: NSManagedObject {
    func toCategoryModel() -> CategoryModel {
        CategoryModel(categoryEntity: self)
    }
}
