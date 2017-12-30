//
//  MovieDataModel.swift
//  TMDbClient
//
//  Created by Anderson Santos Gusmão on 29/12/2017.
//  Copyright © 2017 Anderson Santos Gusmão. All rights reserved.
//

import ObjectMapper

public class MovieDataModel: Mappable {
    // swiftlint:disable:next identifier_name
    var id: Int = -1
    var title: String = String.Empty
    var overview: String = String.Empty
    private var posterPath: String  = String.Empty {
        didSet {
            imageUrl = String("\(Settings.urlImage)\(posterPath)")
        }
    }
    var imageUrl: String = String.Empty
    var releaseDate: Date = Date()

    public required init?(map: Map) {

    }

    public func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        overview <- map["overview"]
        posterPath <- map["poster_path"]
        releaseDate <- (map["release_date"], DateConverter())
    }
}
