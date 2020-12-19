//
//  ProductsUseCase.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/17/20.
//

import Foundation
import Promises

class ProductsUseCase: BaseUseCase {
    
    @Injected private var repository: ProductsRepositoryProtocol
    private var categoryId: String
    private var pageSize: Int, pageNumber: Int

    init(categoryId: String,
         pageSize:Int = 50,
         pageNumber: Int = 1) {
        self.categoryId = categoryId
        self.pageSize = pageSize
        self.pageNumber = pageNumber

    }

    func update(pageSize: Int = 50 , pageNumber: Int) {
        self.pageSize = pageSize
        self.pageNumber = pageNumber
    }

    override func process<T>(_ outputType: T.Type) -> Promise<T> {
        return repository.fetchStock(categoryId: categoryId, pageSize: pageSize, pageNumber: pageNumber) as! Promise<T>
    }
}

