//
//  MovieCollectionDatasource.swift
//  hkSymposium
//
//  Created by Anderson Santos Gusmão on 30/12/2017.
//  Copyright © 2017 Anderson Santos Gusmão. All rights reserved.
//

import Foundation
import UIKit

class MovieCollectionDatasource<Cell: UICollectionViewCell>: NSObject,
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout where Cell: Reusable, Cell: MovieSetupProtocol {

    var collectionView: UICollectionView
    var data: [MovieDataProtocol]
    weak var delegate: MovieCollectionDatasourceDelegate?

    init(collectionView: UICollectionView, delegate: MovieCollectionDatasourceDelegate) {
        self.delegate = delegate
        self.collectionView = collectionView
        self.data = [Movie(),
                     Movie(),
                     Movie(),
                     Movie(),
                     Movie(),
                     Movie(),
                     Movie(),
                     Movie(),
                     Movie(),
                     Movie()]

        super.init()
        self.register()
    }

    private func register() {
        self.collectionView.registerReusableCell(MovieSelectionUICollectionViewCell.self)
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: Cell = collectionView.dequeueReusableCell(indexPath: indexPath)
        cell.setup(model: data[indexPath.row])

        return cell
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height
        if bottomEdge >= scrollView.contentSize.height {
            self.delegate?.onDidStartConnection()
        }
    }
}
