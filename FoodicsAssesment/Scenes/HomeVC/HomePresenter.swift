//
//  HomePresenter.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/17/20.
//


import Foundation

class HomePresenter: BasePresenter<HomeView> {
    
    private var categoriesUseCase: CategoriesUseCase!
    private var categories: [CategoryModel] = []
    
    override func viewDidAttach() {
        getAllCategories()
    }
    
    override func tryAgainBtnTappedFromErrorView() {
        view.hideDefaultErrorView()
        getAllCategories()
    }
    
    func getAllCategories() {
        view.showLoader()
        categoriesUseCase = CategoriesUseCase(pageNumber: 1)
        categoriesUseCase.process([CategoryModel].self).then { [weak self] categories in
            self?.categories = categories
        }.catch { [weak self] (error)in
            self?.view.showErrorView(errorMessage: error.message)
        }.always { [weak self] in
            self?.view.reloadCollectionView()
            self?.view.hideLoader()
        }
    }
    
    //MARK: - collectionView Methods
    
    func numberOfRows() -> Int {
        return categories.count
    }
    
    func category(for indexPath: IndexPath) -> CategoryModel {
        return categories[indexPath.row]
        
    }
    
}
