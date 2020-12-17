//
//  BaseVC.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/17/20.
//

import Foundation
import UIKit

class BaseVC<ViewProtocol, Presenter>: UIViewController, BaseViewProtocol where Presenter: BasePresenter<ViewProtocol> {
    
    @Injected var internetManager: InternetManagerProtocol
    lazy var presenter: Presenter = {
        let presenter: Presenter = Resolver.resolve(args: presenterArgs)
        presenterArgs = nil
        return presenter
    }()
    
    open var presenterArgs: Any?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let view = self as? ViewProtocol else {
            fatalError("Presenter of type \(Presenter.Type.self) need to attach View of type \(ViewProtocol.Type.self)")
        }
        presenter.attach(view: view)
        setupViews()
    }
    open func setupViews() {}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.viewWillDisappear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter.viewDidDisappear()
    }
    
    func showLoader() {
        showAppLoader()
    }
    
    func hideLoader() {
        hideAppLoader()
    }
    
    func showErrorView(errorMessage: String) {
        showErrorView( errorSubTitle: errorMessage)
    }
    
}
