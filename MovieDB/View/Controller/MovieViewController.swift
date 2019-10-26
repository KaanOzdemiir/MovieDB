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
    
    let viewModel = MovieViewModel()
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // MARK: CollectionViews Configirations
        configureTopRatedMovieCollectionView()
        configureNowPlayingMovieCollectionView()
        configurePopularMovieCollectionView()
        
        // MARK: Fetching Top Rated Movies
        viewModel.fetchTopRatedMovieList()

        
        // MARK: Subscribing to Top Rated Movie Response
        subscribeTopRatedMovieResponse()
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
        nowPlayingCollectionView.register(UINib(nibName: "NowPlayingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NowPlayingMovieCellID")
        nowPlayingCollectionView.delegate = self
        nowPlayingCollectionView.dataSource = self
    }

    // MARK: configurePopularMovieCollectionView
    func configurePopularMovieCollectionView() {
        nowPlayingCollectionView.register(UINib(nibName: "PopularMovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PopularMovieMovieCellID")
        nowPlayingCollectionView.delegate = self
        nowPlayingCollectionView.dataSource = self
    }
}

// MARK: UICollectionViewDataSource Extension
extension MovieViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.topRatedMovieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopRatedMovieCellID", for: indexPath) as! TopRatedMovieCollectionViewCell
        
        let topRatedMovie = viewModel.topRatedMovieList[indexPath.item]
        
        cell.setWith(topRatedMovie: topRatedMovie)
        
        return cell
    }
    
    
}

// MARK: UICollectionViewDelegate Extension
extension MovieViewController: UICollectionViewDelegate {
    
}

