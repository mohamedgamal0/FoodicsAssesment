//
//  NSObject+Extension.swift
//  Icon Shop
//
//  Created by mohamed gamal on 9/2/20.
//  Copyright © 2020 mohamed gamal. All rights reserved.
//

import Foundation

extension NSObject {
    /// value that represent a className as string value
    static var className: String {
        return String(describing: self)
    }
}
