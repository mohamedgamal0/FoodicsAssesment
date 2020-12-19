//
//  CategoryModel.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/19/20.
//

import Foundation
struct CategoryModel {
    var id, name, image: String?

    init(categoryEntity :CategoryEntity ) {
        id = categoryEntity.id
        name = categoryEntity.name
        image = categoryEntity.imageURL
    }

    init(categoryAPIModel :CategoryAPIModel ) {
        id = categoryAPIModel.id
        name = categoryAPIModel.name
        image = categoryAPIModel.image
    }

    func toCategoryEntity() -> CategoryEntity {
        let entity = CategoryEntity(entity: CategoryEntity.entity(), insertInto: nil)
            entity.id = id ?? ""
            entity.imageURL = image
            entity.name = name
            return entity
    }
}
