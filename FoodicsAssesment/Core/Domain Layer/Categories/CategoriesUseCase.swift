//
//  CategoriesUseCase.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/17/20.
//

import Foundation
import Promises

class CategoriesUseCase: BaseUseCase {
    @Injected private var repository: CategoriesRepositoryProtocol
    private var pageSize: Int, pageNumber: Int

    init(pageSize: Int = 50, pageNumber: Int)  {
        self.pageSize = pageSize
        self.pageNumber = pageNumber
        super.init()
    }

    func update(pageSize: Int? = nil , pageNumber: Int) {
        self.pageSize = pageSize ?? self.pageSize
        self.pageNumber = pageNumber
    }

    override func process<T>(_ outputType: T.Type) -> Promise<T> {
        return repository.fetchStock(pageSize: pageSize, pageNumber: pageNumber) as! Promise<T>
    }
}

