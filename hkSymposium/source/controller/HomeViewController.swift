//
//  ViewController.swift
//  hkSymposium
//
//  Created by Anderson Santos Gusmão on 29/12/2017.
//  Copyright © 2017 Anderson Santos Gusmão. All rights reserved.
//

import UIKit
import TMDbClient
import NVActivityIndicatorView

class HomeViewController: UICollectionViewController,
                          NVActivityIndicatorViewable,
MovieCollectionDatasourceDelegate {

    var collectionViewSource: MovieCollectionDatasource<MovieSelectionUICollectionViewCell>!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func displayLoader() {
        let size = CGSize(width: 30, height: 30)

        startAnimating(size, message: "Loading...", type: NVActivityIndicatorType(rawValue: 10)!)

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
            NVActivityIndicatorPresenter.sharedInstance.setMessage("Authenticating...")
        }

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.stopAnimating()
        }
    }

    func onDidStartConnection() {
        displayLoader()
    }

    func onDidFinishedConnection(hasError: Bool) {

    }

    func onDidTapOnMovie(movie: Movie) {

    }

    private func setupUI() {
        self.collectionViewSource = MovieCollectionDatasource(collectionView: self.collectionView ?? UICollectionView(),
            delegate: self)
        self.collectionView?.dataSource = self.collectionViewSource
        self.collectionView?.delegate = self.collectionViewSource
    }
}
