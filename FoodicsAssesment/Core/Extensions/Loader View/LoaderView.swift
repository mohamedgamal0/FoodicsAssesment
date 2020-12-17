//
//  LoaderView.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/17/20.
//


import UIKit

class LoaderView: UIView {
    class func instanceFromNib() -> LoaderView {
        return UINib(nibName: "LoaderView",
                     bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! LoaderView
    }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    func show() {
        activityIndicator.startAnimating()
    }
    
    func  showAsBlankView() {
        activityIndicator.isHidden = true
    }
    
    func hide() {
        activityIndicator.stopAnimating()
    }
    
}

extension UIViewController {
    
    var loader: LoaderView {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let window = appDelegate.window!
        for view in window.subviews where view is LoaderView {
            return view as! LoaderView
        }
        for view in self.view.subviews where view is LoaderView {
            return view as! LoaderView
        }
        return LoaderView.instanceFromNib()
    }
    
    func showAppLoader(overContext: Bool = false,
                       onView view: UIView? = nil,
                       with bgColor: UIColor? = nil,
                       showAsBlankView: Bool = false) {
        let loader = self.loader
        if let bgColor = bgColor {
            loader.backgroundColor = bgColor
            loader.activityIndicator.color = UIColor(red: 0.64, green: 0.76, blue: 0.33, alpha: 1.00)
        }
        if overContext {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let window = appDelegate.window!
            for view in window.subviews where view is LoaderView {
                return
            }
            
            loader.frame = window.bounds
            loader.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            window.addSubview(loader)
            
        } else {
            if let view = view {
                loader.frame = view.bounds
                loader.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                view.addSubview(loader)
                if let superview =  view.superview {
                    superview.bringSubviewToFront(view)
                } else {
                    self.view.bringSubviewToFront(view)
                }
            } else {
                loader.frame = self.view.frame
                loader.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                self.view.addSubview(loader)
            }
        }
        showAsBlankView ? loader.showAsBlankView(): loader.show()
    }
    
    func hideAppLoader(from view: UIView? = nil) {
        loader.hide()
        if let view = view {
            if let superview =  view.superview {
                superview.sendSubviewToBack(view)
            } else {
                self.view.sendSubviewToBack(view)
            }
        }
        self.loader.removeFromSuperview()
    }
    
}
