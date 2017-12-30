//
//  ViewController.swift
//  hkSymposium
//
//  Created by Anderson Santos Gusmão on 29/12/2017.
//  Copyright © 2017 Anderson Santos Gusmão. All rights reserved.
//

import UIKit
import TMDbClient

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        MovieApi.shared.getUpcomingMovies(page: 1) { (response) in
            switch response {
            case .success(let dataSet):
                print("")
            case .error:
                print("")
            }
        }
    }
}
