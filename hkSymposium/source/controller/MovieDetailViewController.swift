//
//  MovieDetailViewController.swift
//  hkSymposium
//
//  Created by Anderson Santos Gusmão on 31/12/2017.
//  Copyright © 2017 Anderson Santos Gusmão. All rights reserved.
//

import Foundation
import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var voteAverageProgressBar: UIProgressView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelReleaseDate: UILabel!
    @IBOutlet weak var labelOverview: UILabel!
    var movie: Movie!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

    }

    private func setupUI() {
        if movie.urlImage != String.Empty {
            self.posterImageView.kf.indicatorType = .activity
            self.posterImageView.kf.setImage(with: URL(string: movie.urlImage))
        } else {
            self.posterImageView.image = UIImage(named: "ImageNotFound")
        }

        self.voteAverageProgressBar.setProgress(Float(self.movie.voteAverage / 10), animated: true)
        self.labelOverview.text = movie.overview
        self.labelTitle.text = movie.title
        self.labelReleaseDate.text = (movie.releaseDate?.toString()) ?? String.Empty
    }
}
