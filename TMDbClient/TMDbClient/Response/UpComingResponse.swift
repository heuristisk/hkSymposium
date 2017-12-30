//
//  UpComingResponse.swift
//  TMDbClient
//
//  Created by Anderson Santos Gusmão on 29/12/2017.
//  Copyright © 2017 Anderson Santos Gusmão. All rights reserved.
//

import ObjectMapper

public class UpComingResponse: Mappable {
    var result: [UpComingDataModel]?

    public required init?(map: Map) {

    }

    public func mapping(map: Map) {
        result <- map["results"]
    }
}
