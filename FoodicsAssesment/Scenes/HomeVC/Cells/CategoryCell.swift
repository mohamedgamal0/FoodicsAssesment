//
//  CategoryCellCollectionViewCell.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/17/20.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    @IBOutlet weak var catImage: UIImageView!
    @IBOutlet weak var catTitle: UILabel!
    @IBOutlet weak var continerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.continerView.layer.cornerRadius = 4
        self.continerView.layer.borderWidth = 3
        self.continerView.layer.borderColor = UIColor(red: 0.64, green: 0.76, blue: 0.33, alpha: 1.00).cgColor
    }
    
    func configure(categories: Categories?) {
        catImage.setImage(with: categories?.image ?? "")
        catTitle.text = categories?.name ?? ""
    }
}
