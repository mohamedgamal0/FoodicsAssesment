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
}

// MARK: UICollectionViewDelegateFlowLayout
extension ProductsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: (collectionView.frame.width/2),
                          height: collectionView.frame.height/2)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
