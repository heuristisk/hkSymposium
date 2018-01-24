//
//  GenreDataModel.swift
//  TMDbClient
//
//  Created by Anderson Santos Gusmão on 29/12/2017.
//  Copyright © 2017 Anderson Santos Gusmão. All rights reserved.
//

import ObjectMapper

public class GenreDataModel: Mappable {
    // swiftlint:disable:next identifier_name
    var id: Int = -1
    var name: String = String.empty

    public required init?(map: Map) {

    }

    public func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
}
