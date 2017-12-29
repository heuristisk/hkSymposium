//
//  GenreResponse.swift
//  TMDbClient
//
//  Created by Anderson Santos Gusmão on 29/12/2017.
//  Copyright © 2017 Anderson Santos Gusmão. All rights reserved.
//

import ObjectMapper

public class GenreResponse: Mappable {
    var result: [GenreDataModel]?

    public required init?(map: Map) {

    }

    public func mapping(map: Map) {
        result <- map["genres"]
    }
}
