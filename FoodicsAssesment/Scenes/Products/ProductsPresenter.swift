//
//  ProductsPresenter.swift
//  FoodicsAssesment
//
//  Created mohamed gamal on 12/17/20.
//

import Foundation

class ProductsPresenter: BasePresenter<ProductsView> {
    var categoryId: String!
    private var productsUseCase: ProductsUseCase!
    internal var products: [ProductModel] = []
    
    override func viewDidAttach() {
        getAllProducts()
    }
    
    override func tryAgainBtnTappedFromErrorView() {
        view.hideDefaultErrorView()
        getAllProducts()
    }
    
    func getAllProducts() {
        view.showLoader()
        productsUseCase = ProductsUseCase(categoryId: categoryId,
                                          pageSize: 50,
                                          pageNumber: 1)
        productsUseCase.process([ProductModel].self).then { [weak self] products in
            self?.products = products
        }.catch { [weak self] (error)in
            self?.view.showErrorView(errorMessage: error.message)
        }.always { [weak self] in
            self?.view.reloadCollectionView()
            self?.view.hideLoader()
        }
    }
    
    //MARK: - collectionView Methods
    
    func numberOfRows() -> Int {
        return products.count
    }
    
    func product(for indexPath: IndexPath) -> ProductModel {
        return products[indexPath.row]
        
    }
    
}
