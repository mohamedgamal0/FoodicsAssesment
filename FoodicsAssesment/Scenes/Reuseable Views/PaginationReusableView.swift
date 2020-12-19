//
//  PaginationReusableView.swift
//  El-Araby
//
//  Created by Nesreen Mamdouh on 6/3/20.
//  Copyright © 2020 Robusta. All rights reserved.
//

import UIKit

protocol PaginationDelegate: class {
    func loadMore()
    func scrollToTop()
}

class PaginationReusableView: UICollectionReusableView {

    @IBOutlet private weak var loadMoreButton: UIButton!

    weak var paginationDelegate: PaginationDelegate?

    override func awakeFromNib() {
        loadMoreButton.layer.borderColor = UIColor.black.cgColor
        loadMoreButton.layer.borderWidth = 1
    }

    @IBAction private func loadMoreAction(_ sender: Any) {
        paginationDelegate?.loadMore()
    }

    @IBAction private func scrollToTopAction(_ sender: Any) {
        paginationDelegate?.scrollToTop()
    }
}
