//
//  ProductsContainers.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/17/20.
//

import Foundation

extension Resolver {
    static func registerProductsContainers() {
        register { ProductsVC() }
        register { (_, args) -> ProductsVC in
            let view = ProductsVC()
            view.presenterArgs = args
            return view
        }
        register { (_, args) -> ProductsPresenter in
            let presenter = ProductsPresenter()
            presenter.categoryId = args as? String ?? ""
            return presenter
        }
        
        register { ProductPopUPVC() }
        register { (_, args) -> ProductPopUPVC in
            let view = ProductPopUPVC()
            view.presenterArgs = args
            return view
        }
        register { (_, args) -> ProductPopUPPresenter in
            let presenter = ProductPopUPPresenter()
            presenter.product = args as? Products
            return presenter
        }
    }
}
