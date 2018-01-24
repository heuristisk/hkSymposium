//
//  Movie.swift
//  hkSymposium
//
//  Created by Anderson Santos Gusmão on 30/12/2017.
//  Copyright © 2017 Anderson Santos Gusmão. All rights reserved.
//

import Foundation

class Movie: MovieDataProtocol {
    var title: String = String.empty
    var urlImage: String = String.empty
    var overview: String = String.empty
    var releaseDate: Date?
    var voteAverage: Double = 0.0
}
