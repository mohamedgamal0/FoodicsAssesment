//
//  UIImageView+extension.swift
//  Dr.Online
//
//  Created by mohamed gamal on 10/10/20.
//  Copyright © 2020 mohamed gamal. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func setImage(with urlString: String) {
        let url = URL(string: urlString)
        self.kf.setImage(with: url,
                         placeholder: #imageLiteral(resourceName: "placeholder"),
                         options: [.transition(.fade(1.0))])
    }

    func setImageColor(color: UIColor) {
      let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
      self.image = templateImage
      self.tintColor = color
    }
}

extension UIImage {
    var data : Data? {
        return cgImage?.dataProvider?.data as Data?
    }
}
