//
//  TVSerieCollectionViewCell.swift
//  MovieDB
//
//  Created by Kaan Ozdemir on 27.10.2019.
//  Copyright © 2019 Kaan Ozdemir. All rights reserved.
//

import UIKit
import Kingfisher

class TVSerieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var tvSeriePosterImageView: UIImageView!
    @IBOutlet weak var tvSerieNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setWith(tvSerie: TVSerieResult) {
        if let url = URL(string: tvSerie.posterPath?.url ?? "") {
            let processor = DownsamplingImageProcessor(size: tvSeriePosterImageView.frame.size)
                |> RoundCornerImageProcessor(cornerRadius: 20)
            tvSeriePosterImageView.kf.indicatorType = .activity
            tvSeriePosterImageView.kf.setImage(
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
        tvSerieNameLabel.text = tvSerie.name?.uppercased()
    }
}
