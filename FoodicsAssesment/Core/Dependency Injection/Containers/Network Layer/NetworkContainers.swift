//
//  NetworkContainers.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/17/20.
//

import Foundation

import Foundation

extension Resolver {
    static func registerNetworkLayerContainers() {
        register { APIManager() as NetworkManagerProtocol }
            .scope(Resolver.application)
        register { InternetConnectionManager() as InternetManagerProtocol }
            .scope(Resolver.application)
        register { APIRequestProvider() as APIRequestProviderProtocol }
            .scope(Resolver.application)
        register { CoreDataStackManager(containerName: "FoodicsAssesment") as DataBaseManagerProtocol }
            .scope(Resolver.application)
    }
}
