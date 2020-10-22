//
//  MovieCrewCollectionViewCell.swift
//  MovieDBVIPER
//
//  Created by Kaan Ozdemir on 22.10.2020.
//  Copyright © 2020 Kaan Ozdemir. All rights reserved.
//

import UIKit
import Kingfisher
import MovieDBAPI

class MovieCrewCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var crewMemberPhotoImageView: UIImageView!
    @IBOutlet weak var crewMemberNameLabel: UILabel!
    @IBOutlet weak var departmentOfCrewMember: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        crewMemberPhotoImageView.image = UIImage(named:"questionMark")
    }
    
    func setWith(crew: CrewData) {
        if let url = URL(string: crew.profilePath?.url ?? "") {
            let processor = DownsamplingImageProcessor(size: crewMemberPhotoImageView.frame.size)
                |> RoundCornerImageProcessor(cornerRadius: 20)
            crewMemberPhotoImageView.kf.indicatorType = .activity
            crewMemberPhotoImageView.kf.setImage(
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
        
        crewMemberNameLabel.text = crew.name
        departmentOfCrewMember.text = crew.job
        
    }
    
    func setWith(cast: CastData) {

        if let url = URL(string: cast.profilePath?.url ?? "") {
            let processor = DownsamplingImageProcessor(size: crewMemberPhotoImageView.frame.size)
                |> RoundCornerImageProcessor(cornerRadius: 20)
            crewMemberPhotoImageView.kf.indicatorType = .activity
            crewMemberPhotoImageView.kf.setImage(
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
        
        crewMemberNameLabel.text = cast.name
        departmentOfCrewMember.text = cast.character
        
    }
}
