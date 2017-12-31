//
//  MovieViewModel.swift
//  hkSymposium
//
//  Created by Anderson Santos Gusmão on 30/12/2017.
//  Copyright © 2017 Anderson Santos Gusmão. All rights reserved.
//

import Foundation
import TMDbClient

class MovieViewModel: NSObject {

    private var moviesList = [UpComingDataModel]()
    private var pageIndex = 0

    func getMovieTitle(for indexPath: IndexPath) -> String {
        return self.moviesList[indexPath.row].title
    }

    func getMovieVoteAverage(for indexPath: IndexPath) -> Double {
        return self.moviesList[indexPath.row].voteAverage
    }

    func getMovieReleaseDate(for indexPath: IndexPath) -> Date {
        return self.moviesList[indexPath.row].releaseDate
    }

    func getMovieImageUrl(for indexPath: IndexPath) -> String {
        return self.moviesList[indexPath.row].imageUrl
    }

    func getMovieOverview(for indexPath: IndexPath) -> String {
        return self.moviesList[indexPath.row].overview
    }

    func getNumberOfItems() -> Int {
        return self.moviesList.count
    }

    private func getNextPage() -> Int {
        pageIndex += 1
        return pageIndex
    }

    func load(completion: @escaping (_ hasError: Bool) -> Void) {

        MovieApi.shared.getUpcomingMovies(page: getNextPage()) { (response) in
            switch response {
            case .success(let dataSet):
                DispatchQueue.main.async { [weak self] in
                    self?.moviesList.append(contentsOf: dataSet.result ?? [UpComingDataModel]())
                    completion(false)
                }
            case.error:
                completion(true)
            }
        }
    }
}
