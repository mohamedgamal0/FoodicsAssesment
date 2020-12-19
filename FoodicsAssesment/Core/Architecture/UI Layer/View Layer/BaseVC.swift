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
    var _loader: LoaderView?
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
        
    func showLoader() {
        showAppLoader()
    }
    
    func hideLoader() {
        hideAppLoader()
    }
    
    func showErrorView(errorMessage: String) {
        showErrorView( errorSubTitle: errorMessage)
    }
    
    func setNavBarImage() {
        let logoImage = UIImage(named: "foodics-logo")
        setNavigationItem(image: logoImage!,
                          imageFrameSize: CGSize(width: 60, height: 30))
    }

    @objc func tryAgainBtnTappedFromErrorView() {
        presenter.tryAgainBtnTappedFromErrorView()
    }


}
