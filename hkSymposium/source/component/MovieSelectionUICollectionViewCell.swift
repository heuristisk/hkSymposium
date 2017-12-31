//
//  MovieSelectionUICollectionViewCell.swift
//  hkSymposium
//
//  Created by Anderson Santos Gusmão on 30/12/2017.
//  Copyright © 2017 Anderson Santos Gusmão. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class MovieSelectionUICollectionViewCell: UICollectionViewCell, Reusable, MovieSetupProtocol {

    @IBOutlet weak var backgroundImage: UIImageView!

    func setup(model: MovieDataProtocol) {

        self.backgroundImage.kf.indicatorType = .activity
        self.backgroundImage.kf.setImage(with: URL(string: model.urlImage),
                                 placeholder: nil,
                                 options: nil,
                                 progressBlock: nil,
                                 completionHandler: nil)

    }
}
