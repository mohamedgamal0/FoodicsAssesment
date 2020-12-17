//
//  ErrorModel.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/17/20.
//

import Foundation
struct ErrorModel: Codable {
    let message: String?
    
    init(message: String) {
        self.message = message
    }
}
