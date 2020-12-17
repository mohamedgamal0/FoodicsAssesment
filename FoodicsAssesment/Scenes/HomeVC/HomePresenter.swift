//
//  HomePresenter.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/17/20.
//


import Foundation

class HomePresenter: BasePresenter<HomeView> {
    
    private var categoriesUseCase: CategoriesUseCase!
    internal var categories: [Categories] = []
    
    override func viewDidAttach() {
        getAllCategories()
    }
    
    override func tryAgainBtnTappedFromErrorView() {
        getAllCategories()
    }
    
    func getAllCategories() {
        categoriesUseCase = CategoriesUseCase()
        categoriesUseCase.willProcess = {[weak self] in
            self?.view.showLoader()
        }
        categoriesUseCase?.execute(BaseResponse<[Categories]>.self).then { [weak self] response in
            self?.categories = response.data ?? []
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

    func configureCategories(for indexPath: IndexPath) -> Categories {
        return categories[indexPath.row]

    }
    
}
