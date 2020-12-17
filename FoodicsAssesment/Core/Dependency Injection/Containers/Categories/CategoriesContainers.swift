//
//  HomeContainers.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/17/20.
//

import Foundation
extension Resolver {
    static func registerCategoriesContainers() {
        register { HomeVC() }
        register { HomePresenter() }
    }
}
