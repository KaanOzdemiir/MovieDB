//
//  MovieOrTVSerieDetailViewController.swift
//  MovieDB
//
//  Created by Kaan Ozdemir on 27.10.2019.
//  Copyright © 2019 Kaan Ozdemir. All rights reserved.
//

import UIKit
import Hero

class MovieOrTVSerieDetailViewController: UIViewController {
    
    @IBOutlet weak var backDropImageView: UIImageView!
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel! // Movie Or TV serie name
    @IBOutlet weak var genreLabel: UILabel!
    
    @IBOutlet weak var voteAvrageIntegerValueLabel: UILabel!
    @IBOutlet weak var voteAvrageDecimalValueLabel: UILabel!
    
    @IBOutlet var starImageViews: [UIImageView]!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBOutlet weak var crewAndCastCollectionView: UICollectionView!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    let viewModel = MovieDetailViewModel()
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: Subcribing to movie
        subscribeMovie()
        
        // MARK: Configuring CollectionView
        configureMovieCrewCollectionView()
        
        // MARK: Subscribing to Movie Cast&Crew Response
        subscribeMovieCreditsResponse()
        
        // MARK: Subcribing to TV Serie
        subscribeTVSerie()        
    }
    
    // MARK: Subcription Of TV Serie
    func subscribeTVSerie() {
        viewModel.tvSerie.subscribe(onNext: { (tvSerie) in
            
            print("Got Movie")
            
            if let tvSerieId = tvSerie?.id {
                self.viewModel.fetchTVSerieCharacterList(tvSerieId: tvSerieId)
            }
            
            if let url = URL(string: tvSerie?.backdropPath?.url ?? "") {
                self.backDropImageView.kf.setImage(with: url)
            }
            
            if let url = URL(string: tvSerie?.posterPath?.url ?? "") {
                self.posterImageView.kf.setImage(with: url)
            }
            
            if let name = tvSerie?.name?.uppercased() {
                self.nameLabel.text = name
            }
            
            if let voteAvrage = tvSerie?.voteAverage?.stringValue.split(separator: ".") {
                self.voteAvrageIntegerValueLabel.text = "\(voteAvrage[0])"
                self.voteAvrageDecimalValueLabel.text = ".\(voteAvrage[1])"
            }
            
            if let overview = tvSerie?.overview?.getLineSpacedAttributedText(lineSpacing: 8) {
                self.overviewLabel.attributedText = overview
            }
            
            let startCount = Int((tvSerie?.voteAverage ?? 0)) / 2
            for imageView in 0..<startCount {
                self.starImageViews[imageView].image = #imageLiteral(resourceName: "icStarSelected")
            }
            
            var genreList: [String] = []
            tvSerie?.genreids?.forEach({ (id) in
                if let genre = ApplicationVariables.tvSerieGenreList?.first(where: {$0.id == id})?.name {
                    genreList.append(genre)
                }
            })
            
            if let genres = genreList.getStringFromArraySeperatedByComa() {
                self.genreLabel.text = genres
            }
        })
            .disposed(by: viewModel.disposeBag)
    }
    
    // MARK: Subscription Of Movie Credits Response
    func subscribeMovieCreditsResponse() {
        viewModel.creditsResponse.subscribe(onNext: { [weak self] (movieCreditsResponse) in
            self?.spinner.stopAnimating()
            self?.crewAndCastCollectionView.reloadData()
        }, onError: { (error) in
            print(error.localizedDescription)
        })
            .disposed(by: viewModel.disposeBag)
    }
    
    // MARK: Configuration of Movie Crew Collection View
    func configureMovieCrewCollectionView() {
        crewAndCastCollectionView.register(UINib(nibName: "MovieCrewCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCrewCellID")
        crewAndCastCollectionView.dataSource = self
    }
    
    // MARK: Subcription Of Movie
    func subscribeMovie() {
        viewModel.movie.subscribe(onNext: { (movie) in
            
            print("Got Movie")
            
            if let movieId = movie?.id {
                self.viewModel.fetchMovieCharacterList(movieId: movieId)
                self.posterImageView.heroID = "\(movieId)"
                self.backDropImageView.heroID = "\(movieId)"
                self.nameLabel.heroID = "\(movieId)"
            }
            
            if let url = URL(string: movie?.backdropPath?.url ?? "") {
                self.backDropImageView.kf.setImage(with: url)
            }
            
            if let url = URL(string: movie?.posterPath?.url ?? "") {
                self.posterImageView.kf.setImage(with: url)
            }
            
            if let name = movie?.originalTitle?.uppercased() {
                self.nameLabel.text = name
            }
            
            if let voteAvrage = movie?.voteAverage?.stringValue.split(separator: ".") {
                self.voteAvrageIntegerValueLabel.text = "\(voteAvrage[0])"
                self.voteAvrageDecimalValueLabel.text = ".\(voteAvrage[1])"
            }
            
            if let overview = movie?.overview?.getLineSpacedAttributedText(lineSpacing: 8) {
                self.overviewLabel.attributedText = overview
            }
            
            
            for imageView in 0..<(Int((movie?.voteAverage ?? 0)) / 2) {
                self.starImageViews[imageView].image = #imageLiteral(resourceName: "icStarSelected")
            }
            
            var genreList: [String] = []
            movie?.genreids?.forEach({ (id) in
                if let genre = ApplicationVariables.movieGenreList?.first(where: {$0.id == id})?.name {
                    genreList.append(genre)
                }
            })
            
            if let genres = genreList.getStringFromArraySeperatedByComa() {
                self.genreLabel.text = genres
            }
        })
            .disposed(by: viewModel.disposeBag)
    }
}

extension MovieOrTVSerieDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.crewList.count + viewModel.castList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCrewCellID", for: indexPath) as! MovieCrewCollectionViewCell
        
        
        if viewModel.crewList.count > 0, indexPath.item < viewModel.crewList.count {
            let crew = viewModel.crewList[indexPath.item]
            cell.setWith(crew: crew)
        }
        
        if viewModel.castList.count > 0, indexPath.item < viewModel.castList.count {
            let cast = viewModel.castList[indexPath.item]
            cell.setWith(cast: cast)
        }
        
        return cell
    }
    
    
}
