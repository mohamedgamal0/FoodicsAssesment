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
    private var pageNumber = 1

    override func viewDidAttach() {
        getProducts()
    }
    
    override func tryAgainBtnTappedFromErrorView() {
        pageNumber = 1
        products.removeAll()
        view.reloadCollectionView()
        view.hideDefaultErrorView()
        getProducts()
    }
    
    func getProducts() {
        view.showLoader()
        productsUseCase = ProductsUseCase(categoryId: categoryId,
                                          pageNumber: pageNumber)
        productsUseCase.process([ProductModel].self).then { [weak self] products in
            self?.products.append(contentsOf: products)
        }.catch { [weak self] (error)in
            self?.view.showErrorView(errorMessage: error.message)
        }.always { [weak self] in
            self?.view.reloadCollectionView()
            self?.view.hideLoader()
        }
    }

    func loadMore() {
        pageNumber = pageNumber + 1
        getProducts()
    }

    //MARK: - collectionView Methods
    
    func numberOfRows() -> Int {
        return products.count
    }
    
    func product(for indexPath: IndexPath) -> ProductModel {
        return products[indexPath.row]
    }
    
}
