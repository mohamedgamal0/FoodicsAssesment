//
//  Products.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/17/20.
//

import Foundation

struct ProductAPIModel: Codable {
    let id, name, image: String?
    let price: Double?
    
    func toProductModel() -> ProductModel {
        ProductModel(productAPIModel: self)
    }

}
