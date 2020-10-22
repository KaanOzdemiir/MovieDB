//
//  MoviesVC.swift
//  MovieDB
//
//  Created by Kaan Ozdemir on 11.09.2020.
//  Copyright © 2020 Kaan Ozdemir. All rights reserved.
//

import UIKit
import MovieDBAPI

class MoviesVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.register(UINib(nibName: "CollectionViewTableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewTopRatedCellId")
        }
    }
    
    var presenter: MoviesPresenterProtocol!
    private var topRatedMovies: [MovieData] = []
    private var nowPlayingMovies: [MovieData] = []
    private var popularMovies: [MovieData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.load()
    }
}

extension MoviesVC: MoviesViewProtocol{
    func handleOutput(_ output: MoviesPresenterOutput) {
        
        switch output {
        case .setLoading(let isLoading):
            UIApplication.shared.isNetworkActivityIndicatorVisible = isLoading
        case .updateTitle(let title):
            navigationItem.title = title
        case .showTopRatedMovies(let movies):
            self.topRatedMovies = movies
            self.tableView.reloadRows(at: [.init(row: 0, section: 0)], with: .automatic)
        case .showNowPlayingMovies(let movies):
            self.nowPlayingMovies = movies
            self.tableView.reloadRows(at: [.init(row: 1, section: 0)], with: .automatic)
        case .showPopularMovies(let movies):
            self.popularMovies = movies
            self.tableView.reloadRows(at: [.init(row: 2, section: 0)], with: .automatic)
        }
    }
}

extension MoviesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewTopRatedCellId", for: indexPath) as! CollectionViewTableViewCell
            cell.delegate = self
            cell.index = 0
            cell.topRatedMovies = topRatedMovies
            cell.titleLabel.text = "Top Rated Movies"
            cell.collectionView.reloadData()
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewTopRatedCellId", for: indexPath) as! CollectionViewTableViewCell
            cell.delegate = self
            cell.index = 1
            cell.nowPlayingMovies = nowPlayingMovies
            cell.titleLabel.text = "Now Playing"
            cell.collectionView.reloadData()
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewTopRatedCellId", for: indexPath) as! CollectionViewTableViewCell
            cell.delegate = self
            cell.index = 2
            cell.popularMovies = popularMovies
            cell.titleLabel.text = "Popular"
            cell.collectionView.reloadData()
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    
}

extension MoviesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {        
        switch indexPath.row {
        case 0:
            return 242
        case 1:
            return 382
        case 2:
            return 288
        default:
            return 0
        }
    }
}

extension MoviesVC: CollectionViewTableViewCellProtocol{
    func didSelect(movie: MovieData) {
        presenter.selectMovie(movie: movie)
    }
}
