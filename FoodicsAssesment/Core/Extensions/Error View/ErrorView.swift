//
//  ErrorView.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/17/20.
//


import UIKit

class ErrorView: UIView {
    
    @IBOutlet private weak var tryAgainButton: UIButton!
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var errorSubtitle: UILabel!
    @IBOutlet private weak var refeshImage: UIImageView!
    
    var errorbuttonTryAgainDidtap: (() -> Void)!
    
    class func instanceFromNib() -> ErrorView {
        return UINib(nibName: "ErrorView",
                     bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! ErrorView
    }
    
    func config(errorTitle: String,
                errorSubTitle: String,
                buttonTitle: String,
                errorImage: UIImage,
                buttonIshidden: Bool) {
        tryAgainButton.setTitle(buttonTitle, for: .normal)
        errorLabel.text = errorTitle
        errorSubtitle.text = errorSubTitle
        refeshImage.image = errorImage
        tryAgainButton.isHidden = buttonIshidden
    }
        
    @IBAction private func tryAgainButtonTapped() {
        errorbuttonTryAgainDidtap()
    }
    
}

extension UIViewController {
    
    var errorView: ErrorView {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let window = appDelegate.window!
        
        for view in self.view.subviews where view is ErrorView {
            return view as! ErrorView
        }
        for view in window.subviews where view is ErrorView {
            return view as! ErrorView
        }
        return ErrorView.instanceFromNib()
    }
    
    func showErrorView(overContext: Bool = false,
                       onView view: UIView? = nil,
                       errorTitle: String = "error Message DefaultTitle" ,
                       buttonIshidden: Bool = false,
                       errorSubTitle: String =  "API Failure Error",
                       buttonTitle: String =  "Try Again",
                       errorImage: UIImage = #imageLiteral(resourceName: "warning")) {
        let errorView = self.errorView
        
        errorView.errorbuttonTryAgainDidtap = tryAgainBtnTappedFromErrorView
        errorView.config(errorTitle: errorTitle,
                         errorSubTitle: errorSubTitle,
                         buttonTitle: buttonTitle,
                         errorImage: errorImage,
                         buttonIshidden: buttonIshidden)
        if overContext == true {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let window = appDelegate.window!
            for view in window.subviews where view is ErrorView {
                return
            }
            errorView.frame = window.frame
            window.addSubview(errorView)
        } else {
            if let view = view {
                errorView.frame = view.bounds
                view.addSubview(errorView)
                if let superview =  view.superview {
                    superview.bringSubviewToFront(view)
                } else {
                    self.view.bringSubviewToFront(view)
                }
            } else {
                errorView.frame = self.view.bounds
                self.view.addSubview(errorView)
            }
        }
    }
    
    func hideErrorView(from view: UIView? = nil) {
        if let view = view {
            if let superview =  view.superview {
                superview.sendSubviewToBack(view)
            } else {
                self.view.sendSubviewToBack(view)
            }
        }
        self.errorView.removeFromSuperview()
    }
        
    @objc func tryAgainBtnTappedFromErrorView() {
        fatalError("Need to be implemented")
    }
}
