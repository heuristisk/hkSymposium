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
    weak var delegate: MovieCollectionDatasourceDelegate?
    private var movieViewModel = MovieViewModel()

    init(collectionView: UICollectionView, delegate: MovieCollectionDatasourceDelegate) {
        self.delegate = delegate
        self.collectionView = collectionView
        super.init()
        self.register()
        loadData()
    }

    private func loadData() {
        delegate?.onDidStartConnection()
        movieViewModel.load { (hasError) in
            self.delegate?.onDidFinishedConnection(hasError: hasError)
        }
    }

    private func register() {
        self.collectionView.registerReusableCell(MovieSelectionUICollectionViewCell.self)
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return movieViewModel.getNumberOfItems()
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: Cell = collectionView.dequeueReusableCell(indexPath: indexPath)

        let movie = Movie()
        movie.title = movieViewModel.getMovieTitle(for: indexPath)
        movie.urlImage = movieViewModel.getMovieImageUrl(for: indexPath)
        cell.setup(model: movie)

        return cell
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height
        if bottomEdge >= scrollView.contentSize.height {
            self.loadData()
        }
    }
}
