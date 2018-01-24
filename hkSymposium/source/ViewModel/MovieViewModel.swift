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

    func getMovie(for indexPath: IndexPath) -> Movie {
        let movie = Movie()
        movie.title = self.moviesList[indexPath.row].title
        movie.urlImage = self.moviesList[indexPath.row].imageUrl
        movie.releaseDate = self.moviesList[indexPath.row].releaseDate
        movie.overview = self.moviesList[indexPath.row].overview
        movie.voteAverage = self.moviesList[indexPath.row].voteAverage

        return movie
    }

    var numberOfItems: Int {
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

                DispatchQueue.global().async { [weak self] in
                    self?.moviesList.append(contentsOf: dataSet.result ?? [UpComingDataModel]())
                    completion(false)
                }
            case.error:
                completion(true)
            }
        }
    }
}
