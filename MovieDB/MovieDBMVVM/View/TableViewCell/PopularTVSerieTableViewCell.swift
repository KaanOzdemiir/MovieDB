//
//  PopularTVSerieTableViewCell.swift
//  MovieDB
//
//  Created by Kaan Ozdemir on 27.10.2019.
//  Copyright © 2019 Kaan Ozdemir. All rights reserved.
//

import UIKit
import Kingfisher

class PopularTVSerieTableViewCell: UITableViewCell {

    @IBOutlet weak var tvSeriePosterImageView: UIImageView!
    @IBOutlet weak var voteAvrageContainerView: UIView!
    @IBOutlet weak var voteAvrageIntegerValueLabel: UILabel!
    @IBOutlet weak var voteAvrageDecimalValueLabel: UILabel!
    @IBOutlet weak var tvSerieNameLabel: UILabel!
    
    let gradientStartColor = UIColor(red: 239 / 255, green: 127 / 255, blue: 16 / 255, alpha: 1)
    let gradientEndColor = UIColor(red: 205 / 255, green: 26 / 255, blue: 85 / 255, alpha: 1)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        voteAvrageContainerView.applyGradient(startColor: gradientStartColor, endColor: gradientEndColor)
    }

    func setWith(tvSerie: TVSerieResult) {
        if let url = URL(string: tvSerie.backdropPath?.url ?? "") {
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
        
        if let voteAvrage = tvSerie.voteAverage?.stringValue.split(separator: ".") {
            voteAvrageIntegerValueLabel.text = "\(voteAvrage[0])"
            voteAvrageDecimalValueLabel.text = ".\(voteAvrage[1])"
        }
        
        tvSerieNameLabel.text = tvSerie.name?.uppercased()
        
        if let firstAirDate = tvSerie.firstAirDate?.prefix(4), let name = tvSerie.name?.uppercased() {
            tvSerieNameLabel.text = "\(name)(\(firstAirDate)-)"
        }
    }
    
}
