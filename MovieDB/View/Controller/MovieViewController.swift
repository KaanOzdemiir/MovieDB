//
//  ViewController.swift
//  MovieDB
//
//  Created by Kaan Ozdemir on 26.10.2019.
//  Copyright © 2019 Kaan Ozdemir. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController {
    
    @IBOutlet weak var topRatedMovieCollectionView: UICollectionView!
    @IBOutlet weak var nowPlayingCollectionView: UICollectionView!
    @IBOutlet weak var popularMovieCollectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    
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
        
        // MARK: Fetching Top Rated Movies
        viewModel.fetchNowPlayingMovieList()
        
        // MARK: Subscribing to Popular Movie Response
        subscribePopularMovieResponse()
        
        // MARK: Fetching Popular Movies
        viewModel.fetchPopularMovieList()
        
    }
    
    // MARK: Subscription of Popular Movie Service Response
    func subscribePopularMovieResponse() {
        
        viewModel.popularMovieResponse.subscribe(onNext: { [weak self] (nowPlayingMovieResponse) in
            self?.popularMovieCollectionView.reloadData()
            }, onError: { (error) in
                print(error.localizedDescription)
        })
            .disposed(by: viewModel.disposeBag)
    }
    
    // MARK: Subscription of Now Playing Movie Service Response
    func subscribeNowPlayingMovieResponse() {
        
        viewModel.nowPlayingMovieResponse.subscribe(onNext: { [weak self] (nowPlayingMovieResponse) in
            self?.nowPlayingCollectionView.reloadData()
            }, onError: { (error) in
                print(error.localizedDescription)
        })
            .disposed(by: viewModel.disposeBag)
    }
    
    // MARK: Subscription of Top Rated Movie Service Response
    func subscribeTopRatedMovieResponse() {
        
        viewModel.topRatedMovieResponse.subscribe(onNext: { [weak self] (topRatedMovieResponse) in
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
}

// MARK: UICollectionViewDataSource Extension
extension MovieViewController: UICollectionViewDataSource {
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
            return cell
        case nowPlayingCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NowPlayingMovieCellID", for: indexPath) as! NowPlayingMovieCollectionViewCell
            
            let nowPlayingMovie = viewModel.nowPlayingMovieList[indexPath.item]
            
            cell.setWith(nowPlayingMovie: nowPlayingMovie)
            return cell
            
        default:
            break
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularMovieMovieCellID", for: indexPath) as! PopularMovieCollectionViewCell

        let popularMovie = viewModel.popularMovieList[indexPath.item]
        
        cell.setWith(popularMovie: popularMovie)
        return cell
    }
}

// MARK: UICollectionViewDelegate Extension
extension MovieViewController: UICollectionViewDelegate {
    
}

