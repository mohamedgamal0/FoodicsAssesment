//
//  CategoriesRepository.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/19/20.
//

import Foundation
import Promises

protocol CategoriesRepositoryProtocol: class {
    func changeMCacheToDirty()
    func fetchStock(pageSize: Int, pageNumber: Int) -> Promise<[CategoryModel]>
    @discardableResult func clear() -> Promise<Void>
}

class CategoriesRepository: CategoriesRepositoryProtocol {

    // MARK: - Dependencies
    @Injected(name: .local) private var localDataSource: CategoriesDataSource
    @Injected(name: .remote) private var remoteDataSource: CategoriesDataSource
    @Injected private var internetManager: InternetManagerProtocol

    // MARK: - Queues
    private let fetchingQueue = DispatchQueue(label: "CategoriesRepository.fetch")
    private let savingQueue = DispatchQueue(label: "CategoriesRepository.save")
    private let cacheStateAccessQueue = DispatchQueue(label: "CategoriesRepo.safe.cache.State",
                                                      attributes: .concurrent)
    private let cachedCategoriesAccessQueue = DispatchQueue(label: "CategoriesRepo.safe.cached.Categories",
                                                            attributes: .concurrent)
    // MARK: - Cached Properties
    private var _mCachedCategories: [CategoryModel]?
    private var mCachedCategories: [CategoryModel]? {
        return cachedCategoriesAccessQueue.sync { [weak self] in
            return self?._mCachedCategories
        }
    }
    private var _mCacheIsDirty = false
    private var mCacheIsDirty: Bool {
        return cacheStateAccessQueue.sync { [weak self] in
            return self?._mCacheIsDirty ?? true
        }
    }
    
    // MARK: - Logs Categories Repository Protocol
    func changeMCacheToDirty() {
        cacheStateAccessQueue.async( flags: .barrier, execute: {
            self._mCacheIsDirty = true
        })
    }

    func fetchStock(pageSize: Int, pageNumber: Int) -> Promise<[CategoryModel]> {
        let result  = Promise<[CategoryModel]>.pending()
        fetchingQueue.async {[weak self] in
            guard let self = self else { return }
            if let mCachedCategories = self.mCachedCategories, !self.mCacheIsDirty,
               mCachedCategories.count >= pageNumber * pageSize {
                let rangeStart = (pageNumber - 1) * pageSize
                let categories = Array(mCachedCategories[rangeStart...rangeStart+(pageSize-1)])
                result.fulfill(categories)
                return
            }
            self.fetchStockFromLocal(pageSize: pageSize, pageNumber: pageNumber)
                .recover { (error)-> Promise<[CategoryModel]> in
                    if self.internetManager.isInternetConnectionAvailable() {
                        return self.fetchStockFromRemote(pageSize: pageSize, pageNumber: pageNumber)
                    }
                    return .init(NSError.noInternet)
                }.then { (categories)  in
                    result.fulfill(categories)
                }.catch(result.reject(_:))
        }
        return result

    }


    func clear() -> Promise<Void> {
        localDataSource.distroy()
    }

    // MARK: - Fetching Logic
    private func fetchStockFromLocal(pageSize: Int, pageNumber: Int) -> Promise<[CategoryModel]> {
        let reseult = Promise<[CategoryModel]>.pending()
        localDataSource.fetch(pageSize: pageSize, pageNumber: pageNumber)
            .then { [weak self] categories in
                guard let self = self else { return }
                self.refreshMCashed(categories: categories)
                self.changeMCacheToHealthy()
                reseult.fulfill(categories)
            }.catch(reseult.reject(_:))
        return reseult
    }

    private func fetchStockFromRemote(pageSize: Int, pageNumber: Int) -> Promise<[CategoryModel]> {
        let reseult = Promise<[CategoryModel]>.pending()
        remoteDataSource.fetch(pageSize: pageSize, pageNumber: pageNumber)
            .then { [weak self] categories in
                guard let self = self else { return }
                self.refreshMCashed(categories: categories)
                self.localDataSource.save(categories)
                self.changeMCacheToHealthy()
                reseult.fulfill(categories)}
            .catch(reseult.reject(_:))
        return reseult
    }

    private func changeMCacheToHealthy() {
        cacheStateAccessQueue.async( flags: .barrier, execute: {
            self._mCacheIsDirty = false
        })
    }

    private func refreshMCashed(categories: [CategoryModel]) {
        cachedCategoriesAccessQueue.async( flags: .barrier, execute: {
            self._mCachedCategories = categories
        })
    }


}
