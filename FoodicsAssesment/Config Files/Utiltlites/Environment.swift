//
//  Environment.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/17/20.
//

import Foundation
public struct Environment {
    fileprivate var infoDict: [String: Any] {
        if let dict = Bundle.main.infoDictionary {
            return dict
        } else {
            fatalError("Plist file not found")
        }
    }
    public func configration (_ key: PlistKey) -> NSString {
        guard let keyValue = infoDict[key.value()] as? NSString else {
            fatalError("Key \(key.value()) Not founded")
        }
        return keyValue
    }
}
