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

    weak private var  viewHolder: AnyObject!
    var view: ViewProtocol {
        guard let view = viewHolder as? ViewProtocol else {
            fatalError("View of type \(ViewProtocol.Type.self) not attaced Yet")
        }
        return view
    }

    func attach(view: ViewProtocol) {
        self.viewHolder =  view as AnyObject
        viewDidAttach()
    }

    open func viewDidAttach() { }

    open func tryAgainBtnTappedFromErrorView() {
        fatalError("Need to be implemented in sub Presenter")
    }
}
