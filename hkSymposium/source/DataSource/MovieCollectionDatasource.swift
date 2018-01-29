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
        movieViewModel.load { [weak self] (hasError) in
            self?.delegate?.onDidFinishedConnection(hasError: hasError)
        }
    }

    private func register() {
        self.collectionView.registerReusableCell(MovieSelectionUICollectionViewCell.self)
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return movieViewModel.numberOfItems
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: Cell = collectionView.dequeueReusableCell(indexPath: indexPath)
        let movie = movieViewModel.getMovie(for: indexPath)
        cell.setup(model: movie)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movieViewModel.getMovie(for: indexPath)
        delegate?.onDidTapOnMovie(movie: movie)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let realCotentAreaWidth = UIScreen.main.bounds.width - 6
        let collectionViewSize = realCotentAreaWidth
        return CGSize(width: collectionViewSize * 0.5, height: UIScreen.main.bounds.height * 0.45)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {

        if UIApplication.shared.statusBarOrientation == .portrait {
            return UIEdgeInsets(top: 0, left: 60, bottom: 0, right: 60)
        } else {
            if UIScreen.main.bounds.height > 480 {
                return UIEdgeInsets(top: 0, left: 190, bottom: 0, right: 190)
            } else {
                return UIEdgeInsets(top: 0, left: 150, bottom: 0, right: 150)
            }
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let bottomEdge = scrollView.contentOffset.x + scrollView.frame.size.width
        if bottomEdge >= scrollView.contentSize.width {
            self.loadData()
        }
    }
}
