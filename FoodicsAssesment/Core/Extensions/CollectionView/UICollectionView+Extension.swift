//
//  UICollectionView+Extensions.swift
//  EtisalatSports
//
//  Created by Mohamed Gamal on 8/10/19.
//  Copyright © 2019 AppCorp. All rights reserved.
//

import UIKit

extension UICollectionView {

    enum SupplementaryView {
        case header
        case footer
        var id: String {
            switch self {
            case .header:
                return UICollectionView.elementKindSectionHeader
            case .footer:
                return UICollectionView.elementKindSectionFooter
            }
        }
    }

    func register<T: UICollectionReusableView>(supplementaryViewType: T.Type, kind: SupplementaryView) {
        let nib = UINib(nibName: supplementaryViewType.className, bundle: nil)
        self.register(nib, forSupplementaryViewOfKind: kind.id, withReuseIdentifier: supplementaryViewType.className)
    }
    func register<T: UICollectionViewCell>(cellType: T.Type) {
        let nib = UINib(nibName: cellType.className, bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: cellType.className)
    }
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        let cell = self.dequeueReusableCell(withReuseIdentifier: T.className, for: indexPath)
        return cell as! T
    }
    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind: UICollectionView.SupplementaryView,
                                                                       for indexPath: IndexPath) -> T {
        let supplementaryView = self.dequeueReusableSupplementaryView(ofKind: ofKind.id,
                                                                      withReuseIdentifier: T.className, for: indexPath)
        return supplementaryView as! T
    }
}
