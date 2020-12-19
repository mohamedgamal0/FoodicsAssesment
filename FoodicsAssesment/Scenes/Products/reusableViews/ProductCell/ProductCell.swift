//
//  ProductCell.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/17/20.
//

import UIKit

class ProductCell: UICollectionViewCell {
    //MARK:- OutLets
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var continerView: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.continerView.layer.cornerRadius = 8
        self.continerView.layer.borderWidth = 3
        self.continerView.layer.borderColor = UIColor.black.cgColor
    }
    
    func configureProducts(products: ProductModel) {
        productImage.setImage(with: products.image ?? "")
        productTitle.text = products.name ?? ""
        priceLabel.text = "Price: \(products.price ?? 0.0)"
    }
}
