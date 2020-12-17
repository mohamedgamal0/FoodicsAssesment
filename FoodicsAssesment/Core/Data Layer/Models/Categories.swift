//
//  Categories.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/17/20.
//

import Foundation

struct BaseResponse<T: Codable>: Codable {
    var data: T?
}

//MARK: - CategoriesModel
struct Categories: Codable {
    let id, name, image: String?
}
