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

    public enum ResponseEnum<T> {
        case success(T)
        case error
    }

    private func getUrl(_ path: String) -> String {
        return String.init(format: MovieApi.address, path, MovieApi.apiKey, Settings.apiLocale)
    }

    public func getGenres(callback: @escaping GenreResponseCallback) {

        let path = "genre/movie/list"

        Alamofire.request(getUrl(path)).responseObject { (response: DataResponse<GenreResponse>) in
            if let statusCode = response.response?.statusCode {
                switch statusCode {
                case 200:
                    if let genreResponse = response.result.value {
                        callback(.success(genreResponse))
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

    public func getMoviesByGenre(genderId: Int, callback: @escaping MovieResponseCallback) {

        let path = String("genre/\(genderId)/movies")

        Alamofire.request(getUrl(path)).responseObject { (response: DataResponse<MovieResponse>) in
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
