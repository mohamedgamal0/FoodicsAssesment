//
//  ProductsRepository.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/19/20.
//

import Foundation
import Promises

protocol ProductsRepositoryProtocol: class {
    func changeMCacheToDirty()
    func fetchStock(categoryId:String,
                    pageSize: Int,
                    pageNumber: Int) -> Promise<[ProductModel]>
    @discardableResult func clear() -> Promise<Void>
}

class ProductsRepository: ProductsRepositoryProtocol {

    // MARK: - Dependencies
    @Injected(name: .local) private var localDataSource: ProductsDataSource
    @Injected(name: .remote) private var remoteDataSource: ProductsDataSource
    @Injected private var internetManager: InternetManagerProtocol

    // MARK: - Queues
    private let fetchingQueue = DispatchQueue(label: "ProductsRepository.fetch")
    private let savingQueue = DispatchQueue(label: "ProductsRepository.save")
    private let cacheStateAccessQueue = DispatchQueue(label: "ProductsRepo.safe.cache.State",
                                                      attributes: .concurrent)
    private let cachedProductsAccessQueue = DispatchQueue(label: "ProductsRepo.safe.cached.Products",
                                                            attributes: .concurrent)
    // MARK: - Cached Properties
    private var _mCachedProducts: [String:[ProductModel]] = [:]
    private var mCachedProducts: [String:[ProductModel]]? {
        return cachedProductsAccessQueue.sync { [weak self] in
            return self?._mCachedProducts
        }
    }
    private var _mCacheIsDirty = false
    private var mCacheIsDirty: Bool {
        return cacheStateAccessQueue.sync { [weak self] in
            return self?._mCacheIsDirty ?? true
        }
    }
    
    // MARK: - Logs Products Repository Protocol
    func changeMCacheToDirty() {
        cacheStateAccessQueue.async( flags: .barrier, execute: {
            self._mCacheIsDirty = true
        })
    }

    func fetchStock(categoryId:String, pageSize: Int, pageNumber: Int) -> Promise<[ProductModel]> {
        let result  = Promise<[ProductModel]>.pending()
        fetchingQueue.async {[weak self] in
            guard let self = self else { return }
            if let mCachedProducts = self.mCachedProducts?[categoryId], !self.mCacheIsDirty,
               mCachedProducts.count >= pageNumber * pageSize {
                let rangeStart = (pageNumber - 1) * pageSize
                let products = Array(mCachedProducts[rangeStart...rangeStart+(pageSize-1)])
                result.fulfill(products)
                return
            }
            self.fetchStockFromLocal(categoryId: categoryId, pageSize: pageSize, pageNumber: pageNumber)
                .recover { (error)-> Promise<[ProductModel]> in
                    if self.internetManager.isInternetConnectionAvailable() {
                        return self.fetchStockFromRemote(categoryId: categoryId, pageSize: pageSize, pageNumber: pageNumber)
                    }
                    return .init(NSError.noInternet)
                }.then { (products)  in
                    result.fulfill(products)
                }.catch(result.reject(_:))
        }
        return result

    }


    func clear() -> Promise<Void> {
        localDataSource.distroy()
    }

    // MARK: - Fetching Logic
    private func fetchStockFromLocal(categoryId: String, pageSize: Int, pageNumber: Int) -> Promise<[ProductModel]> {
        let reseult = Promise<[ProductModel]>.pending()
        localDataSource.fetch(categoryId: categoryId, pageSize: pageSize, pageNumber: pageNumber)
            .then { [weak self] products in
                guard let self = self else { return }
                self.refreshMCashed(categoryId: categoryId, products: products)
                self.changeMCacheToHealthy()
                reseult.fulfill(products)
            }.catch(reseult.reject(_:))
        return reseult
    }

    private func fetchStockFromRemote(categoryId: String, pageSize: Int, pageNumber: Int) -> Promise<[ProductModel]> {
        let reseult = Promise<[ProductModel]>.pending()
        remoteDataSource.fetch(categoryId: categoryId, pageSize: pageSize, pageNumber: pageNumber)
            .then { [weak self] products in
                guard let self = self else { return }
                self.refreshMCashed(categoryId: categoryId, products: products)
                self.localDataSource.save(categoryId: categoryId, stocks: products)
                self.changeMCacheToHealthy()
                reseult.fulfill(products)}
            .catch(reseult.reject(_:))
        return reseult
    }

    private func changeMCacheToHealthy() {
        cacheStateAccessQueue.async( flags: .barrier, execute: {
            self._mCacheIsDirty = false
        })
    }

    private func refreshMCashed(categoryId:String,  products: [ProductModel]) {
        cachedProductsAccessQueue.async( flags: .barrier, execute: {
            var allProducts = self._mCachedProducts[categoryId] ?? []
            allProducts.append(contentsOf: products)
            self._mCachedProducts[categoryId] = allProducts
        })
    }


}
