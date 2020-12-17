//
//  NavigationItem+Extention.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/17/20.
//

import UIKit

extension UIViewController {
    func setNavigationItem(image: UIImage, imageFrameSize: CGSize ) {
        
        let imageView = UIImageView(image: image)
        
        let titleView = UIView(frame: .init(origin: .zero,
                                            size: .init(width: UIScreen.main.bounds.width/2,
                                                        height: 44)))
        imageView.frame.origin = .init(x: (UIScreen.main.bounds.width/4) - (imageFrameSize.width/2),
                                       y: (44/2) - (imageFrameSize.height/2))
        imageView.frame.size =  imageFrameSize
        titleView.addSubview(imageView)
        navigationItem.titleView = titleView
    }
}
