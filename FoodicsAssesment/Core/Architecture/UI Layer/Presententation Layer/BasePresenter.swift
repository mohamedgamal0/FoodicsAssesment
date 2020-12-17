//
//  BasePresenter.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/17/20.
//

import Foundation

import UIKit
import Promises

class BasePresenter<ViewProtocol> {
    @Injected var network: NetworkManagerProtocol
    public var providers: [APIRequestProviderProtocol] = [Resolver.resolve()]
    weak private var  viewHolder: AnyObject!
    var view: ViewProtocol {
        guard let view = viewHolder as? ViewProtocol else {
            fatalError("View of type \(ViewProtocol.Type.self) not attaced Yet")
        }
        return view
    }
    var isViewAttached: Bool {
        _isViewAttached
    }
    var isViewWillDisappear: Bool {
        _isViewWillDisappear
    }
    var isViewDidDisappear: Bool {
        _isViewDidDisappear
    }
    var isViewWillAppear: Bool {
        _isViewWillAppear
    }
    var isViewDidAppear: Bool {
        _isViewDidAppear
    }
    private var _isViewAttached: Bool = false
    private var _isViewWillDisappear: Bool = false
    private var _isViewDidDisappear: Bool = false
    private var _isViewWillAppear: Bool = false
    private var _isViewDidAppear: Bool = false

    func attach(view: ViewProtocol) {
        self.viewHolder =  view as AnyObject
        viewDidAttach()
    }

    open func viewDidAttach() {
        _isViewAttached = true
    }
    open func viewWillDisappear() {
        _isViewWillDisappear = true
    }
    open func viewDidDisappear() {
        _isViewDidDisappear = true
    }
    open func viewWillAppear() {
        _isViewWillAppear = true

    }
    open func viewDidAppear() {
        _isViewDidAppear = true
    }
    open func tryAgainBtnTappedFromErrorView() {
        fatalError("Need to be implemented in sub Presenter")
    }

    @discardableResult
    open func perform<T: Codable>(apiRequest: APIRequestProtocol,
                                  provider: APIRequestProviderProtocol? = nil,
                                  outputType: T.Type) -> Promise<T> {
        let provider = provider ?? providers[0]
        return network.perform(apiRequest: apiRequest, providerType: provider, outputType: outputType)
    }
}
