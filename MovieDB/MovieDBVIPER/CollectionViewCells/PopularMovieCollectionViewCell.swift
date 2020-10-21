//
//  PopularMovieCollectionViewCell.swift
//  MovieDBVIPER
//
//  Created by Kaan Ozdemir on 11.09.2020.
//  Copyright © 2020 Kaan Ozdemir. All rights reserved.
//

import UIKit
import Kingfisher

class PopularMovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var voteAvrageIntegerValueLabel: UILabel!
    @IBOutlet weak var voteAvrageDecimalValueLabel: UILabel!
    @IBOutlet weak var voteAvrageContainerView: UIView!
    
    let gradientStartColor = UIColor(red: 239 / 255, green: 127 / 255, blue: 16 / 255, alpha: 1)
    let gradientEndColor = UIColor(red: 205 / 255, green: 26 / 255, blue: 85 / 255, alpha: 1)
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        voteAvrageContainerView.applyGradient(startColor: gradientStartColor, endColor: gradientEndColor)

    }

    func setWith(popularMovie: MovieResult) {
        if let url = URL(string: popularMovie.posterPath?.url ?? "") {
            let processor = DownsamplingImageProcessor(size: moviePosterImageView.frame.size)
                |> RoundCornerImageProcessor(cornerRadius: 20)
            moviePosterImageView.kf.indicatorType = .activity
            moviePosterImageView.kf.setImage(
                with: url,
                placeholder: nil,
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ])
            {
                result in
                switch result {
                case .success(let value):
                    print("Task done for: \(value.source.url?.absoluteString ?? "")")
                case .failure(let error):
                    print("Job failed: \(error.localizedDescription)")
                }
            }
        }

        if let voteAvrage = popularMovie.voteAverage?.stringValue.split(separator: ".") {
            voteAvrageIntegerValueLabel.text = "\(voteAvrage[0])"
            voteAvrageDecimalValueLabel.text = ".\(voteAvrage[1])"
        }
    }
}
