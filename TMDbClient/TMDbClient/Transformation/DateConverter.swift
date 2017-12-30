//
//  DateConverter.swift
//  TMDbClient
//
//  Created by Anderson Santos Gusmão on 30/12/2017.
//  Copyright © 2017 Anderson Santos Gusmão. All rights reserved.
//

import Foundation
import ObjectMapper

class DateConverter: TransformType {

    typealias Object = Date
    typealias JSON = String

    func transformFromJSON(_ value: Any?) -> Object? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: String(describing: value ?? String.Empty))
    }

    func transformToJSON(_ value: Object?) -> JSON? {
        let date: Date = value!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return  dateFormatter.string(from: date)
    }
}
