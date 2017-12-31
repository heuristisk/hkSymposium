//
//  UICollectionView.swift
//  hkSymposium
//
//  Created by Anderson Santos Gusmão on 30/12/2017.
//  Copyright © 2017 Anderson Santos Gusmão. All rights reserved.
//

import UIKit

extension UICollectionView {
    func registerReusableCell<T: UICollectionViewCell>(_: T.Type) where T: Reusable {
        if let nib = T.nib {
            self.register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
        }
    }

    func dequeueReusableCell<T: UICollectionViewCell>(indexPath: IndexPath) -> T where T: Reusable {
        return (self.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T)!
    }

    func registerReusableSupplementaryView<T: Reusable>(_ elementKind: String, _: T.Type) {
        if let nib = T.nib {
            self.register(nib, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(T.self, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: T.reuseIdentifier)
        }
    }

    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(_ elementKind: String,
                                                                       indexPath: IndexPath) -> T where T: Reusable {
        return (self.dequeueReusableSupplementaryView(ofKind: elementKind,
                                                      withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T)!
    }
}
