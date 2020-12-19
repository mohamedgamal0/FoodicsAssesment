//
//  DataBaseManagerProtocol.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/19/20.
//

import Foundation
import Promises

protocol DataBaseManagerProtocol: class {

    // Clears all records
    func clear() -> Promise<Void>
    func start() -> Promise<Void>
    func insert<Input>(data: Input) -> Promise<Void>
    func fetch<Query, Output>(query: Query, outputType: Output.Type) -> Promise<[Output]>
    func save() -> Promise<Void>
}
