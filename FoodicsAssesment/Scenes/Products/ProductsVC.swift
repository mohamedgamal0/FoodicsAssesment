//
//  ProductsVC.swift
//  FoodicsAssesment
//
//  Created mohamed gamal on 12/17/20.
//

import UIKit

protocol ProductsVCDelegate: class {
    func showPopUp(product: ProductModel)
}
protocol ProductsView: BaseViewProtocol {
    func reloadCollectionView()
}

class ProductsVC: BaseVC<ProductsView, ProductsPresenter>, ProductsView {
    @IBOutlet weak var collectionView: UICollectionView!
    // MARK: - Outlets
    //MARK: - Vars
    weak var delegate: ProductsVCDelegate?
    override func setupViews() {
        setupCollectionView()
        setNavBarImage()
    }
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: ProductCell.self)
        collectionView.register(supplementaryViewType: PaginationReusableView.self,
                                kind: .footer)

    }
    func reloadCollectionView() {
        self.collectionView.reloadData()
    }
}

// MARK: UICollectionViewDataSource
extension ProductsVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ProductCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configureProducts(products: presenter.product(for: indexPath))
        return cell
        
    }
}

// MARK: UICollectionViewDelegate
extension ProductsVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        popVC(completion: { [weak self] in
            let product = self?.presenter.product(for:indexPath)
            self?.delegate?.showPopUp(product: product!)
        })
    }
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        let footerView: PaginationReusableView
        footerView = collectionView.dequeueReusableSupplementaryView(ofKind: .footer,
                                                                     for: indexPath)
        footerView.paginationDelegate = self
        return footerView
    }

}

// MARK: UICollectionViewDelegateFlowLayout
extension ProductsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: ((collectionView.bounds.width - 15) / 4),
                          height: collectionView.bounds.height/4)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width , height: 150)
    }

}
extension ProductsVC: PaginationDelegate {
    func scrollToTop() {
        collectionView.scrollToItem(at: IndexPath(row: 0,
                                                  section: 0),
                                    at: .top,
                                    animated: true)
    }

    func loadMore() {
        presenter.loadMore()
    }
}
