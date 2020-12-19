//
//  ProductModel.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/19/20.
//

import Foundation

struct ProductModel {
    var id, name, image: String?
    var price: Double?

    init(productEntity :ProductEntity ) {
        id = String(productEntity.id?.split(separator: " ").first ?? "")
        name = productEntity.name
        image = productEntity.imageURL
        price = productEntity.price
    }

    init(productAPIModel :ProductAPIModel ) {
        id = productAPIModel.id
        name = productAPIModel.name
        image = productAPIModel.image
        price = productAPIModel.price
    }

    func toProductEntity(categoryId:String) -> ProductEntity {
        let entity = ProductEntity(entity: ProductEntity.entity(), insertInto: nil)
        entity.id = "(\(id ?? "") \(categoryId))"
        entity.imageURL = image
        entity.name = name
        entity.price = price ?? 0
        entity.categoryId = categoryId
        return entity
    }
}
