//
//  MovieDetailVC.swift
//  MovieDB
//
//  Created by Kaan Ozdemir on 21.10.2020.
//  Copyright © 2020 Kaan Ozdemir. All rights reserved.
//

import UIKit
import SkeletonView
import MovieDBAPI

class MovieDetailVC: UIViewController {
    
    @IBOutlet weak var backDropImageView: UIImageView!
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel! // Movie Or TV serie name
    @IBOutlet weak var genreLabel: UILabel!
    
    @IBOutlet weak var voteAvrageIntegerValueLabel: UILabel!
    @IBOutlet weak var voteAvrageDecimalValueLabel: UILabel!
    
    @IBOutlet var starImageViews: [UIImageView]!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBOutlet weak var crewAndCastTitleLabel: UILabel!
    @IBOutlet weak var crewAndCastCollectionView: UICollectionView!{
        didSet{
            crewAndCastCollectionView.register(UINib(nibName: "MovieCrewCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCrewCellID")
        }
    }
        
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return .lightContent
        }else {
            return .default
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    var presenter: MovieDetailPresenterProtocol!
    
    var crewList: [CrewData] = []
    var castList: [CastData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSkeletonView()
        presenter.load()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: SkeletonView Configirations
    func configureSkeletonView() {
        if #available(iOS 12.0, *) {
            if self.traitCollection.userInterfaceStyle == .dark {
                // User Interface is Dark
                view.showAnimatedSkeleton(usingColor: UIColor(red: 20 / 255, green: 23 / 255, blue: 22 / 255, alpha: 1))
                
            } else {
                // User Interface is Light
                let gradient = SkeletonGradient(baseColor: UIColor(red: 240 / 255, green: 243 / 255, blue: 242 / 255, alpha: 1))
                let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .topLeftBottomRight, duration: 2)
                view.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation)
            }
        } else {
            // Fallback on earlier versions
            view.showAnimatedSkeleton(usingColor: UIColor(red: 240 / 255, green: 242 / 255, blue: 244 / 255, alpha: 1))
        }
    }
    
    func setData(_ movie: MovieData) {
        if let url = URL(string: movie.backdropPath?.url ?? "") {
            self.backDropImageView.kf.setImage(with: url)
            backDropImageView.hideSkeleton()
        }
        
        if let url = URL(string: movie.posterPath?.url ?? "") {
            self.posterImageView.kf.setImage(with: url)
            posterImageView.hideSkeleton()
        }
        
        if let name = movie.originalTitle?.uppercased() {
            self.nameLabel.text = name
            nameLabel.hideSkeleton()
        }
        
        if let voteAvrage = movie.voteAverage?.stringValue.split(separator: ".") {
            self.voteAvrageIntegerValueLabel.text = "\(voteAvrage[0])"
            self.voteAvrageDecimalValueLabel.text = ".\(voteAvrage[1])"
            voteAvrageIntegerValueLabel.hideSkeleton()
            voteAvrageDecimalValueLabel.hideSkeleton()
        }
        
        if let overview = movie.overview?.getLineSpacedAttributedText(lineSpacing: 8) {
            self.overviewLabel.attributedText = overview
            overviewLabel.hideSkeleton()
        }
        
        
        for imageView in 0..<(Int((movie.voteAverage ?? 0).rounded(.toNearestOrEven) / 2)) {
            self.starImageViews[imageView].image = #imageLiteral(resourceName: "icStarSelected")
        }
        
        starImageViews.forEach { (imageView) in
            imageView.hideSkeleton()
        }
        
//        var genreList: [String] = []
//        movie.genreids?.forEach({ (id) in
//            if let genre = ApplicationVariables.movieGenreList?.first(where: {$0.id == id})?.name {
//                genreList.append(genre)
//            }
//        })
        
//        if let genres = genreList.getStringFromArraySeperatedByComa() {
//            self.genreLabel.text = genres
//            genreLabel.hideSkeleton()
//        }
    }
}

extension MovieDetailVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return crewList.count + castList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCrewCellID", for: indexPath) as! MovieCrewCollectionViewCell
        
        
        if crewList.count > 0, indexPath.item < crewList.count {
            let crew = crewList[indexPath.item]
            cell.setWith(crew: crew)
        }
        
        if castList.count > 0, indexPath.item < castList.count {
            let cast = castList[indexPath.item]
            cell.setWith(cast: cast)
        }
        
        return cell
    }
    
    
}


extension MovieDetailVC: MovieDetailViewProtocol{
    func update(_ movie: MovieData) {
    }
    
    func handleOutput(_ output: MovieDetailPresenterOutput) {
        switch output {
        case .showMovie(let movie):
            print(movie)
            setData(movie)
        case .showCrew(let crew):
            self.crewList = crew
            crewAndCastCollectionView.reloadData()
            crewAndCastTitleLabel.hideSkeleton()
            crewAndCastCollectionView.hideSkeleton()
            view.hideSkeleton()
        case .showCast(let cast):
            self.castList = cast
            crewAndCastCollectionView.reloadData()
            crewAndCastTitleLabel.hideSkeleton()
            crewAndCastCollectionView.hideSkeleton()
            view.hideSkeleton()
        default:
            break
        }
    }
}
