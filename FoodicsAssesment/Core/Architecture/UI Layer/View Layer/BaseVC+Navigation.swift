//
//  BaseVC+Navigation.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/17/20.
//

import UIKit
extension UIViewController {
    
    func pushVC(viewController: UIViewController, completion: (() -> Void)? = nil) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func presentVC(_ viewController: UIViewController, completion: (() -> Void)? = nil) {
        present(viewController, animated: true, completion: completion)
    }
    
    func popVC() {
        navigationController?.popViewController(animated: true)
    }
    func popVC(completion: (() -> Void)?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popVC()
        CATransaction.commit()
    }
    func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    func dismiss(completion: (() -> Void)?) {
        self.dismiss(animated: true, completion: completion)
    }

}
