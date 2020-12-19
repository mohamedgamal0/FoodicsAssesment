//
//  Resolver+ResolverRegistering.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/17/20.
//

import Foundation

extension ContainerIdentifier {
    public static var local = ContainerIdentifier(id: "Local")
    public static var remote = ContainerIdentifier(id: "remote")
}

extension Resolver: ResolverRegistering {
    
    public static func registerAllServices() {
        registerNetworkLayerContainers()
        registerCategoriesContainers()
        registerProductsContainers()
        registerCategoriesRepository()
        registerProductsRepository()
    }

    static func registerCategoriesRepository() {
        register { CategoriesRepository() as CategoriesRepositoryProtocol}.scope(Resolver.application)
        register( name: .local,
                  factory: { LocalCategoriesDataSource() as CategoriesDataSource })
            .scope(application)
        register( name: .remote,
                 factory: { RemoteCategoriesDataSource() as CategoriesDataSource })
            .scope(application)

    }

    static func registerProductsRepository() {
        register { ProductsRepository() as ProductsRepositoryProtocol}.scope(Resolver.application)
        register( name: .local,
                  factory: { LocalProductsDataSource() as ProductsDataSource })
            .scope(application)
        register( name: .remote,
                 factory: { RemoteProductsDataSource() as ProductsDataSource })
            .scope(application)

    }

}
