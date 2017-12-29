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

        MovieApi.shared.getGenres { (response) in

            switch response {
            case .error:
                print("")
            case .success(let dataSet):
                print("")
            }
        }
    }
}
