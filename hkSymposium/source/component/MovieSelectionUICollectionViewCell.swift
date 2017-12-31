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

    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!

    func setup(model: MovieDataProtocol) {
        self.labelTitle.text = model.title
        if model.urlImage != String.Empty {
            self.backgroundImage.kf.indicatorType = .activity
            self.backgroundImage.kf.setImage(with: URL(string: model.urlImage))
            bottomView.isHidden = true
        } else {
            self.backgroundImage.image = UIImage(named: "ImageNotFound")
            bottomView.isHidden = false
        }
    }
}
