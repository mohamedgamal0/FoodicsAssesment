//
//  BaseViewProtocol.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/17/20.
//

import Foundation

protocol BaseViewProtocol: AnyObject {
    func showLoader()
    func hideLoader()
    func showErrorView( errorMessage: String)
}