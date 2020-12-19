//
//  HomeVC.swift
//  FoodicsAssesment
//
//  Created by mohamed gamal on 12/17/20.
//

import UIKit

protocol HomeView: BaseViewProtocol {
    func reloadCollectionView()
}
class HomeVC: BaseVC<HomeView, HomePresenter>, HomeView {
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    // MARK: - Lifecycle
    override func setupViews() {
        setupCollectionView()
        setNavBarImage()
    }
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: CategoryCell.self)
    }
    func reloadCollectionView() {
        self.collectionView.reloadData()
    }
}

// MARK: UICollectionViewDataSource
extension HomeVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CategoryCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configure(category: presenter.category(for: indexPath))
        return cell
        
    }
}

// MARK: UICollectionViewDelegate
extension HomeVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = presenter.category(for: indexPath).id ?? ""
        let productsVC: ProductsVC = Resolver.resolve(args: id)
        productsVC.delegate = self
        pushVC(viewController: productsVC)
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension HomeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: (collectionView.frame.width/3),
                          height: collectionView.frame.height/3)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


extension HomeVC: ProductsVCDelegate {
    func showPopUp(product: ProductModel) {
        let productPopUpVC: ProductPopUPVC = Resolver.resolve(args: product)
        self.addChild(productPopUpVC)
        productPopUpVC.view.frame = self.view.frame
        self.view.addSubview(productPopUpVC.view)
        productPopUpVC.didMove(toParent: self)

    }
    
    
}
