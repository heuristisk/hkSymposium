//
//  MovieCollectionDatasourceDelegate.swift
//  hkSymposium
//
//  Created by Anderson Santos Gusmão on 30/12/2017.
//  Copyright © 2017 Anderson Santos Gusmão. All rights reserved.
//

import Foundation

protocol MovieCollectionDatasourceDelegate: class {
    func onDidStartConnection()
    func onDidFinishedConnection(hasError: Bool)
    func onDidTapOnMovie(movie: Movie)
}
