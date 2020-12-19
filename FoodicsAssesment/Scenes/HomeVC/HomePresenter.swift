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
    private var pageNumber = 1
    override func viewDidAttach() {
        getCategories()
    }
    
    override func tryAgainBtnTappedFromErrorView() {
        pageNumber = 1
        categories.removeAll()
        view.reloadCollectionView()
        view.hideDefaultErrorView()
        getCategories()
    }
    
    func getCategories() {
        view.showLoader()
        categoriesUseCase = CategoriesUseCase(pageNumber: pageNumber)
        categoriesUseCase.process([CategoryModel].self).then { [weak self] categories in
            self?.categories.append(contentsOf: categories)
        }.catch { [weak self] (error)in
            guard let self = self else { return}
            self.pageNumber =  self.pageNumber == 1 ? 1 : self.pageNumber-1
            self.view.showErrorView(errorMessage: error.message)
        }.always { [weak self] in
            self?.view.reloadCollectionView()
            self?.view.hideLoader()
        }
    }
    func loadMore() {
        pageNumber = pageNumber + 1
        getCategories()
    }
    //MARK: - collectionView Methods
    func numberOfRows() -> Int {
        return categories.count
    }
    
    func category(for indexPath: IndexPath) -> CategoryModel {
        return categories[indexPath.row]
    }
    
}
