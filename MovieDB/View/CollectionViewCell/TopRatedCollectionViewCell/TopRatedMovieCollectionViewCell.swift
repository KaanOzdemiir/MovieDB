//
//  TopRatedMovieCollectionViewCell.swift
//  MovieDB
//
//  Created by Kaan Ozdemir on 26.10.2019.
//  Copyright © 2019 Kaan Ozdemir. All rights reserved.
//

import UIKit
import Kingfisher

class TopRatedMovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var movieBackDropImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func setWith(topRatedMovie: MovieResult) {
        if let url = URL(string: topRatedMovie.backdropPath?.url ?? "") {
            let processor = DownsamplingImageProcessor(size: movieBackDropImageView.frame.size)
                |> RoundCornerImageProcessor(cornerRadius: 20)
            movieBackDropImageView.kf.indicatorType = .activity
            movieBackDropImageView.kf.setImage(
                with: url,
                placeholder: #imageLiteral(resourceName: "placeHolderImage"),
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
    }
}
