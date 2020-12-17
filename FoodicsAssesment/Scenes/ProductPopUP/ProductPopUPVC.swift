//
//  ProductPopUPVC.swift
//  FoodicsAssesment
//
//  Created mohamed gamal on 12/17/20.
//

import UIKit

protocol ProductPopUPView: BaseViewProtocol {
    
    func showProduct(product: Products?)
}

class ProductPopUPVC: BaseVC<ProductPopUPView, ProductPopUPPresenter>, ProductPopUPView {
   
    // MARK: - Outlets
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    // MARK: - Variables
    
    // MARK: - Lifecycle
    override func setupViews() {
        self.showPopUpAnimate()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        self.view.layer.cornerRadius = 8
    }
    
    func showProduct(product: Products?) {
        productImage.setImage(with: product?.image ?? "")
        productTitle.text = product?.name ?? ""
        productPrice.text = "Price: \(product?.price ?? 0.0)"
    }

    func dismissView() {
        removePopUpAnimate()
    }

    // MARK: - IBActions
    @IBAction func exitTapped(_ sender: Any) {
        removePopUpAnimate()
    }

}
