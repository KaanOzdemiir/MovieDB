//
//  NowPlayingCollectionViewCell.swift
//  MovieDBVIPER
//
//  Created by Kaan Ozdemir on 11.09.2020.
//  Copyright © 2020 Kaan Ozdemir. All rights reserved.
//

import UIKit
import Kingfisher
import MovieDBAPI

class NowPlayingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setWith(nowPlayingMovie: MovieData) {
        if let url = URL(string: nowPlayingMovie.posterPath?.url ?? "") {
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
        movieNameLabel.text = nowPlayingMovie.originalTitle?.uppercased()
    }
}
