//
//  MovieApi.swift
//  TMDbClient
//
//  Created by Anderson Santos Gusmão on 29/12/2017.
//  Copyright © 2017 Anderson Santos Gusmão. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

public class MovieApi {

    public static var shared = MovieApi(apiKey: Settings.apiKey)

    private static let address = "\(Settings.apiUrl)\(Settings.apiVersion)/%@?api_key=%@&language=%@"
    private static var apiKey = String.Empty

    public init(apiKey: String) {
        MovieApi.apiKey = apiKey
    }

    public typealias GenreResponseCallback = (ResponseEnum<GenreResponse>) -> Void
    public typealias MovieResponseCallback = (ResponseEnum<MovieResponse>) -> Void
    public typealias UpcomingMovieResponseCallback = (ResponseEnum<UpComingResponse>) -> Void

    public enum ResponseEnum<T> {
        case success(T)
        case error
    }

    private func getUrl(_ path: String) -> String {
        return String.init(format: MovieApi.address, path, MovieApi.apiKey, Settings.apiLocale)
    }

    public func getGenres(callback: @escaping GenreResponseCallback) {
        let path = "genre/movie/list"
        self.requester(path: getUrl(path), callback: callback)
    }

    public func getMoviesByGenre(genderId: Int, callback: @escaping MovieResponseCallback) {
        let path = String("genre/\(genderId)/movies")
        self.requester(path: getUrl(path), callback: callback)
    }

    public func getUpcomingMovies(page: Int = 1, callback: @escaping UpcomingMovieResponseCallback) {
        let path = String("movie/upcoming")
        self.requester(path: String("\(getUrl(path))&page=\(page)"), callback: callback)
    }

    private func requester<T: Mappable>(path: String, callback: @escaping (ResponseEnum<T>) -> Void) {

        Alamofire.request(path).responseObject { (response: DataResponse<T>) in
            if let statusCode = response.response?.statusCode {
                switch statusCode {
                case 200:
                    if let movieResponse = response.result.value {
                        callback(.success(movieResponse))
                    } else {
                        callback(.error)
                    }
                default:
                    callback(.error)
                }
            } else if response.error != nil {
                callback(.error)
            }
        }
    }
}
