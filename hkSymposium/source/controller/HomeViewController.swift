//
//  ViewController.swift
//  hkSymposium
//
//  Created by Anderson Santos Gusmão on 29/12/2017.
//  Copyright © 2017 Anderson Santos Gusmão. All rights reserved.
//

import UIKit
import TMDbClient

class HomeViewController: UICollectionViewController {

    var collectionViewSource: MovieCollectionDatasource<MovieSelectionUICollectionViewCell>!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        self.collectionViewSource = MovieCollectionDatasource(collectionView: self.collectionView ?? UICollectionView())
        self.collectionView?.dataSource = self.collectionViewSource
        self.collectionView?.delegate = self.collectionViewSource
    }
}
