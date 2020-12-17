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
    internal var products: [Products] = []
    
    override func viewDidAttach() {
        getAllProducts()
    }
    
    override func tryAgainBtnTappedFromErrorView() {
        getAllProducts()
    }
    
    func getAllProducts() {
        productsUseCase = ProductsUseCase(catId: categoryId)
        productsUseCase.willProcess = {[weak self] in
            self?.view.showLoader()
        }
        productsUseCase?.execute(BaseResponse<[Products]>.self).then { [weak self] response in
            self?.products = response.data ?? []
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
    
    func configureProducts(for indexPath: IndexPath) -> Products {
        return products[indexPath.row]
        
    }
    
}
