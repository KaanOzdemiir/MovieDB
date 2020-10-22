//
//  CollectionViewTableViewCell.swift
//  MovieDBVIPER
//
//  Created by Kaan Ozdemir on 11.09.2020.
//  Copyright © 2020 Kaan Ozdemir. All rights reserved.
//

import UIKit
import MovieDBAPI

class CollectionViewTableViewCell: UITableViewCell {

    weak var delegate: CollectionViewTableViewCellProtocol?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var index = 0
    var topRatedMovies: [MovieData] = []
    var nowPlayingMovies: [MovieData] = []
    var popularMovies: [MovieData] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureCollectionView()
    }
    
    func configureCollectionView() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "TopRatedMovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TopRatedCellId")
        collectionView.register(UINib(nibName: "NowPlayingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NowPlayingCellId")
        collectionView.register(UINib(nibName: "PopularMovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PopularCellId")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension CollectionViewTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch index {
        case 0:
            return topRatedMovies.count
        case 1:
            return nowPlayingMovies.count
        case 2:
            return popularMovies.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch index {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopRatedCellId", for: indexPath) as! TopRatedMovieCollectionViewCell
            let movie = topRatedMovies[indexPath.item]
            cell.setWith(topRatedMovie: movie)
            return cell
            
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NowPlayingCellId", for: indexPath) as! NowPlayingCollectionViewCell
            let movie = nowPlayingMovies[indexPath.item]
            cell.setWith(nowPlayingMovie: movie)
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularCellId", for: indexPath) as! PopularMovieCollectionViewCell
            let movie = popularMovies[indexPath.item]
            cell.setWith(popularMovie: movie)
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
}

extension CollectionViewTableViewCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch index {
        case 0:
            let movie = topRatedMovies[indexPath.item]
            delegate?.didSelect(movie: movie)
        case 1:
            let movie = nowPlayingMovies[indexPath.item]
            delegate?.didSelect(movie: movie)
        case 2:
            let movie = popularMovies[indexPath.item]
            delegate?.didSelect(movie: movie)
        default:
            break
        }
    }
    
}

extension CollectionViewTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch index {
        case 0:
            return .init(width: self.frame.width, height: 188)
        case 1:
            return .init(width: 160, height: 328)
        case 2:
            return .init(width: 160, height: 238)
        default:
            return .zero
        }
    }
}

protocol CollectionViewTableViewCellProtocol: class {
    func didSelect(movie: MovieData)
}
