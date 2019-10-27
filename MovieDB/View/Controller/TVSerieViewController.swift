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
    @IBOutlet weak var tvSerieCollectionView: UICollectionView!
    
    @IBOutlet weak var popularTVSerieTableView: UITableView!
    
    @IBOutlet weak var popularTVSerieTableViewHeightAnchor: NSLayoutConstraint!
    let viewModel = TVSerieViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
    }
    
    // MARK: Subscription of Popular TV Serie Service Response
    func subscribePopularTVSerieResponse() {
        
        viewModel.popularTVSerieResponse.subscribe(onNext: { [weak self] (popularTVSerieResponse) in
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
            self?.tvSerieCollectionView.reloadData()
            }, onError: { (error) in
                print(error.localizedDescription)
        })
            .disposed(by: viewModel.disposeBag)
    }
    
    // MARK: configureTVSerieCollectionView
    func configureTVSerieCollectionView() {
        tvSerieCollectionView.register(UINib(nibName: "TVSerieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TVSerieCellID")
        tvSerieCollectionView.delegate = self
        tvSerieCollectionView.dataSource = self
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
    
}
