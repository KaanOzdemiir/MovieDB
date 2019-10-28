//
//  TVViewController.swift
//  MovieDB
//
//  Created by Kaan Ozdemir on 27.10.2019.
//  Copyright © 2019 Kaan Ozdemir. All rights reserved.
//

import UIKit

class TVSerieViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var topRatedTVSerieCollectionView: UICollectionView!
    
    @IBOutlet weak var popularTVSerieTableView: UITableView!
    
    @IBOutlet weak var popularTVSerieTableViewHeightAnchor: NSLayoutConstraint!
    
    @IBOutlet weak var topRatedTVSerieSpinner: UIActivityIndicatorView!
    @IBOutlet weak var popularTVSerieSpinner: UIActivityIndicatorView!
    
    let viewModel = TVSerieViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topRatedTVSerieSpinner.startAnimating()
        popularTVSerieSpinner.startAnimating()
        
        // MARK: TVSerieCollectionView Configirations
        configureTVSerieCollectionView()
        
        // MARK: Subscribing to Top Rated TV Serie Response
        subscribeTopRatedTVSerieResponse()
        
        // MARK: Fetching Top Rated TV Series
        viewModel.fetchTopRatedTVSerieList()
        
        // MARK: PopularTVSerieTableView Configirations
        configurePopularTVSerieTableView()
        
        // MARK: Subscribing to Popular TV Serie Response
        subscribePopularTVSerieResponse()
        
        // MARK: Fetching Popular TV Series
        viewModel.fetchPopularTVSerieList()
        
        // MARK: Fetching TV Genres
        viewModel.fetchTVSerieGenreList()
    }
    
    // MARK: Subscription of Popular TV Serie Service Response
    func subscribePopularTVSerieResponse() {
        
        viewModel.popularTVSerieResponse.subscribe(onNext: { [weak self] (popularTVSerieResponse) in
            self?.popularTVSerieSpinner.stopAnimating()
            self?.popularTVSerieTableView.reloadData()
            
            let height = CGFloat(self!.viewModel.popularTVSerieList.count) * self!.popularTVSerieTableView.rowHeight
            self?.popularTVSerieTableViewHeightAnchor.constant = height
            self?.scrollView.contentSize.height = height + 372 // 372 ->> Static Height Value until tableView
            }, onError: { (error) in
                print(error.localizedDescription)
        })
            .disposed(by: viewModel.disposeBag)
    }
    
    func configurePopularTVSerieTableView() {
        popularTVSerieTableView.register(UINib(nibName: "PopularTVSerieTableViewCell", bundle: nil), forCellReuseIdentifier: "PopularTVSerieCellID")
        popularTVSerieTableView.delegate = self
        popularTVSerieTableView.dataSource = self
    }
    
    // MARK: Subscription of Top Rated TV Serie Service Response
    func subscribeTopRatedTVSerieResponse() {
        
        viewModel.tvSerieResponse.subscribe(onNext: { [weak self] (tvSerieResponse) in
            self?.topRatedTVSerieSpinner.stopAnimating()
            self?.topRatedTVSerieCollectionView.reloadData()
            }, onError: { (error) in
                print(error.localizedDescription)
        })
            .disposed(by: viewModel.disposeBag)
    }
    
    // MARK: configureTVSerieCollectionView
    func configureTVSerieCollectionView() {
        topRatedTVSerieCollectionView.register(UINib(nibName: "TVSerieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TVSerieCellID")
        topRatedTVSerieCollectionView.delegate = self
        topRatedTVSerieCollectionView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueTVSerieDetailVC" {
            let tvSerieDetailVC = segue.destination as! MovieOrTVSerieDetailViewController
            let tvSerie = sender as! TVSerieResult
            tvSerieDetailVC.viewModel.tvSerie.onNext(tvSerie)
        }
    }
}

// MARK: UITableViewDataSource Extension
extension TVSerieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.popularTVSerieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PopularTVSerieCellID", for: indexPath) as! PopularTVSerieTableViewCell
        
        let tvSerie = viewModel.popularTVSerieList[indexPath.item]
        
        cell.setWith(tvSerie: tvSerie)
        return cell
    }
    
    
}

// MARK: UITableViewDelegate Extension
extension TVSerieViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tvSerie = viewModel.popularTVSerieList[indexPath.item]
        self.performSegue(withIdentifier: "SegueTVSerieDetailVC", sender: tvSerie)
    }
}

// MARK: UICollectionViewDataSource Extension
extension TVSerieViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.tvSerieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TVSerieCellID", for: indexPath) as! TVSerieCollectionViewCell
        
        let tvSerie = viewModel.tvSerieList[indexPath.item]
        
        cell.setWith(tvSerie: tvSerie)
        return cell
        
    }
}

// MARK: UICollectionViewDelegate Extension
extension TVSerieViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tvSerie = viewModel.tvSerieList[indexPath.item]
        self.performSegue(withIdentifier: "SegueTVSerieDetailVC", sender: tvSerie)
    }
}
