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
    var id: Int?
    var title: String?
    var overview: String?
    private var posterPath: String? {
        didSet {
            imageUrl = String("\(Settings.urlImage)\(posterPath ?? String.Empty)")
        }
    }
    var imageUrl: String?
    var releaseDate: Date?

    public required init?(map: Map) {

    }

    public func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        overview <- map["overview"]
        posterPath <- map["poster_path"]
        releaseDate <- map["release_date"]
    }
}

