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

// MARK: - Meta
struct Meta: Codable {
    let currentPage, from, lastPage: Int
    let path: String
    let perPage, to, total: Int
    
    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case from
        case lastPage = "last_page"
        case path
        case perPage = "per_page"
        case to, total
    }
}
