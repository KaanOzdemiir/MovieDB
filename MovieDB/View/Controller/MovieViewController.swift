//
//  ViewController.swift
//  MovieDB
//
//  Created by Kaan Ozdemir on 26.10.2019.
//  Copyright © 2019 Kaan Ozdemir. All rights reserved.
//

import UIKit
import Hero
import SkeletonView

class MovieViewController: UIViewController {
    
    @IBOutlet weak var topRatedMovieCollectionView: UICollectionView!
    @IBOutlet weak var nowPlayingCollectionView: UICollectionView!
    @IBOutlet weak var popularMovieCollectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    @IBOutlet weak var nowPlayingTitleLabel: UILabel!
    @IBOutlet weak var popularMovieTitleLabel: UILabel!
    let viewModel = MovieViewModel()
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // MARK: CollectionViews Configirations
        configureTopRatedMovieCollectionView()
        configureNowPlayingMovieCollectionView()
        configurePopularMovieCollectionView()
        
        
        // MARK: Subscribing to Top Rated Movie Response
        subscribeTopRatedMovieResponse()
        
        // MARK: Fetching Top Rated Movies
        viewModel.fetchTopRatedMovieList()
        
        // MARK: Subscribing to Now Playing Movie Response
        subscribeNowPlayingMovieResponse()
        
        // MARK: Fetching Now Playing Movies
        viewModel.fetchNowPlayingMovieList()
        
        // MARK: Subscribing to Popular Movie Response
        subscribePopularMovieResponse()
        
        // MARK: Fetching Popular Movies
        viewModel.fetchPopularMovieList()
        
        //MARK: Fetching Genres
        viewModel.fetchMovieGenreList()
        
        // MARK: SkeletonView Configirations
        configureSkeletonView()
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
    
    // MARK: Subscription of Popular Movie Service Response
    func subscribePopularMovieResponse() {
        
        viewModel.popularMovieResponse.subscribe(onNext: { [weak self] (nowPlayingMovieResponse) in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self?.popularMovieCollectionView.hideSkeleton()
                self?.popularMovieTitleLabel.hideSkeleton()
            }
            self?.popularMovieCollectionView.reloadData()
            }, onError: { (error) in
                print(error.localizedDescription)
        })
            .disposed(by: viewModel.disposeBag)
    }
    
    // MARK: Subscription of Now Playing Movie Service Response
    func subscribeNowPlayingMovieResponse() {
        
        viewModel.nowPlayingMovieResponse.subscribe(onNext: { [weak self] (nowPlayingMovieResponse) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self?.nowPlayingCollectionView.hideSkeleton()
                self?.nowPlayingTitleLabel.hideSkeleton()
            }
            self?.nowPlayingCollectionView.reloadData()
            }, onError: { (error) in
                print(error.localizedDescription)
        })
            .disposed(by: viewModel.disposeBag)
    }
    
    // MARK: Subscription of Top Rated Movie Service Response
    func subscribeTopRatedMovieResponse() {
        
        viewModel.topRatedMovieResponse.subscribe(onNext: { [weak self] (topRatedMovieResponse) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self?.topRatedMovieCollectionView.hideSkeleton()
            }
            self?.topRatedMovieCollectionView.reloadData()
            }, onError: { (error) in
                print(error.localizedDescription)
        })
            .disposed(by: viewModel.disposeBag)
    }
    
    // MARK: configureTopRatedMovieCollectionView
    func configureTopRatedMovieCollectionView() {
        topRatedMovieCollectionView.register(UINib(nibName: "TopRatedMovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TopRatedMovieCellID")
        topRatedMovieCollectionView.delegate = self
        topRatedMovieCollectionView.dataSource = self
    }
    
    // MARK: nowPlayingCollectionView
    func configureNowPlayingMovieCollectionView() {
        nowPlayingCollectionView.register(UINib(nibName: "NowPlayingMovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NowPlayingMovieCellID")
        nowPlayingCollectionView.delegate = self
        nowPlayingCollectionView.dataSource = self
    }
    
    // MARK: configurePopularMovieCollectionView
    func configurePopularMovieCollectionView() {
        popularMovieCollectionView.register(UINib(nibName: "PopularMovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PopularMovieMovieCellID")
        popularMovieCollectionView.delegate = self
        popularMovieCollectionView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueMovieDetailVC" {
            let movieDetailVC = segue.destination as! MovieOrTVSerieDetailViewController
            let movie = sender as! MovieResult
            movieDetailVC.viewModel.movie.onNext(movie)
        }
    }
}

// MARK: UICollectionViewDataSource Extension
extension MovieViewController: SkeletonCollectionViewDataSource {

    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        
        switch skeletonView {
        case topRatedMovieCollectionView:
            return "TopRatedMovieCellID"
        case nowPlayingCollectionView:
            return "NowPlayingMovieCellID"
        case popularMovieCollectionView:
            return "PopularMovieMovieCellID"
        default:
            return ""
        }
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch skeletonView {
        case topRatedMovieCollectionView:
            return viewModel.topRatedMovieList.count
        case nowPlayingCollectionView:
            return viewModel.nowPlayingMovieList.count
        case popularMovieCollectionView:
            return viewModel.popularMovieList.count
        default:
            return 0
        }
    }
    
    func numSections(in collectionSkeletonView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case topRatedMovieCollectionView:
            return viewModel.topRatedMovieList.count
        case nowPlayingCollectionView:
            return viewModel.nowPlayingMovieList.count
        case popularMovieCollectionView:
            return viewModel.popularMovieList.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case topRatedMovieCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopRatedMovieCellID", for: indexPath) as! TopRatedMovieCollectionViewCell
            
            let topRatedMovie = viewModel.topRatedMovieList[indexPath.item]
            
            cell.setWith(topRatedMovie: topRatedMovie)
            
            if let id = topRatedMovie.id {
                cell.heroID = "\(id)"
            }
            
            return cell
        case nowPlayingCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NowPlayingMovieCellID", for: indexPath) as! NowPlayingMovieCollectionViewCell
            
            let nowPlayingMovie = viewModel.nowPlayingMovieList[indexPath.item]
            
            if let id = nowPlayingMovie.id {
                cell.moviePosterImageView.heroID = "\(id)"
                cell.movieNameLabel.heroID = "\(id)"
            }
            
            cell.setWith(nowPlayingMovie: nowPlayingMovie)
            return cell
            
        default:
            break
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularMovieMovieCellID", for: indexPath) as! PopularMovieCollectionViewCell

        let popularMovie = viewModel.popularMovieList[indexPath.item]
        
        if let id = popularMovie.id {
            cell.moviePosterImageView.heroID = "\(id)"
        }
        
        cell.setWith(popularMovie: popularMovie)
        return cell
    }
}

// MARK: UICollectionViewDelegate Extension
extension MovieViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch collectionView {
        case topRatedMovieCollectionView:
            let movie = viewModel.topRatedMovieList[indexPath.item]
            self.performSegue(withIdentifier: "SegueMovieDetailVC", sender: movie)
        case nowPlayingCollectionView:
        let movie = viewModel.nowPlayingMovieList[indexPath.item]
        self.performSegue(withIdentifier: "SegueMovieDetailVC", sender: movie)
        case popularMovieCollectionView:
        let movie = viewModel.popularMovieList[indexPath.item]
        self.performSegue(withIdentifier: "SegueMovieDetailVC", sender: movie)
        default:
            break
        }
      
    }
}

