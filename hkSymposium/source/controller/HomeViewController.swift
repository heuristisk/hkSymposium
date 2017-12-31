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

    func onDidStartConnection() {
        let size = CGSize(width: 60, height: 60)
        startAnimating(size, message: "Loading...", type: NVActivityIndicatorType(rawValue: 10)!)
    }

    func onDidFinishedConnection(hasError: Bool) {
        if self.collectionView?.dataSource == nil &&
            self.collectionView?.delegate == nil {
            if hasError == false {
            self.collectionView?.dataSource = self.collectionViewSource
            self.collectionView?.delegate = self.collectionViewSource
            } else {
                self.collectionView?.backgroundView = Bundle.main.loadNibNamed("EmptyStateUIView",
                                                                        owner: self,
                                                                        options: nil)?.first as? UIView
            }
        }

        self.collectionView?.reloadData()
        self.stopAnimating()
    }

    func onDidTapOnMovie(movie: Movie) {
        self.performSegue(withIdentifier: Destination.MovieDetailView, sender: movie)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Destination.MovieDetailView {
            if let movie = sender as? Movie, let controller = segue.destination as? MovieDetailViewController {
                controller.movie = movie
            }
        }
    }

    private func setupUI() {
        self.collectionViewSource = MovieCollectionDatasource(collectionView: self.collectionView ?? UICollectionView(),
            delegate: self)
        self.collectionView?.dataSource = nil
        self.collectionView?.delegate = nil
    }
}
