//
//  Resolver+ResolverRegistering.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/17/20.
//

import Foundation

extension Resolver: ResolverRegistering {
    
    public static func registerAllServices() {
        registerNetworkLayerContainers()
        registerCategoriesContainers()
        registerProductsContainers()
    }
}
