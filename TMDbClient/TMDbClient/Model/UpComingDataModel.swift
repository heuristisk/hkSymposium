//
//  UpComingDataModel.swift
//  TMDbClient
//
//  Created by Anderson Santos Gusmão on 29/12/2017.
//  Copyright © 2017 Anderson Santos Gusmão. All rights reserved.
//

import ObjectMapper

public class UpComingDataModel: Mappable {
    // swiftlint:disable:next identifier_name
    public var id: Int = -1
    public var voteCount: Int = -1
    public var video: Bool = false
    public var voteAverage: Double = 0.0
    public var title: String = String.Empty
    public var popularity: String = String.Empty
    private var posterPath: String  = String.Empty {
        didSet {
            imageUrl = String("\(Settings.urlImage)\(posterPath)")
        }
    }
    public var imageUrl: String = String.Empty
    public var releaseDate: Date = Date()
    public var overview: String = String.Empty

    public required init?(map: Map) {

    }

    public func mapping(map: Map) {
        id <- map["id"]
        voteCount <- map["vote_count"]
        video <- map["video"]
        voteAverage <- map["vote_average"]
        title <- map["title"]
        popularity <- map["popularity"]
        posterPath <- map["poster_path"]
        releaseDate <- (map["release_date"], DateConverter())
        overview <- map["overview"]
    }
}
