//
//  Movie.swift
//  hkSymposium
//
//  Created by Anderson Santos Gusmão on 30/12/2017.
//  Copyright © 2017 Anderson Santos Gusmão. All rights reserved.
//

import Foundation

class Movie: MovieDataProtocol {
    var title: String = String.Empty
    var urlImage: String = String.Empty
    var overview: String = String.Empty
    var releaseDate: Date?
    var voteAverage: Double = 0.0
}
