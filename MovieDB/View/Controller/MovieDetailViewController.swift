//
//  MovieDetailViewController.swift
//  MovieDB
//
//  Created by Kaan Ozdemir on 27.10.2019.
//  Copyright © 2019 Kaan Ozdemir. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var backDropImageView: UIImageView!
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieGenreLabel: UILabel!
    
    @IBOutlet weak var voteAvrageIntegerValueLabel: UILabel!
    @IBOutlet weak var voteAvrageDecimalValueLabel: UILabel!
    
    @IBOutlet weak var firstStarImageView: UIImageView!
    @IBOutlet weak var secondStarImageView: UIImageView!
    @IBOutlet weak var thirdStarImageView: UIImageView!
    @IBOutlet weak var fourthStarImageView: UIImageView!
    @IBOutlet weak var fifthStarImageView: UIImageView!
    
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    
    @IBOutlet weak var movieCrewCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}
