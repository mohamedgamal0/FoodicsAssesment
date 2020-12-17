//
//  ProductPopUPPresenter.swift
//  FoodicsAssesment
//
//  Created mohamed gamal on 12/17/20.
//

import Foundation

class ProductPopUPPresenter: BasePresenter<ProductPopUPView> {
    var product: Products!
    override func viewDidAttach() {
        self.view.showProduct(product: product)
    }
}
