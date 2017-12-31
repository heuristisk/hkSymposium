//
//  Date.swift
//  hkSymposium
//
//  Created by Anderson Santos Gusmão on 31/12/2017.
//  Copyright © 2017 Anderson Santos Gusmão. All rights reserved.
//

import Foundation

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return  dateFormatter.string(from: self)
    }
}
