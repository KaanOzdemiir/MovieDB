//
//  MoviesInteractor.swift
//  MovieDB
//
//  Created by Kaan Ozdemir on 21.10.2020.
//  Copyright © 2020 Kaan Ozdemir. All rights reserved.
//

import Foundation
import RxSwift

class MoviesInteractor: MoviesInteractorProtocol {
    weak var delegate: MoviesInteractorDelegate?
    
    private let movieRepository = MovieRespository()
    private let disposeBag = DisposeBag()
    private var movies: [MovieResult] = []
    init() {
        
    }
    
    func load() {
        delegate?.handleOutput(.setLoading(true))
        fetchTopRatedMovieList()
        fetchNowPlayingMovieList()
        fetchPopularMovieList()
    }
    
    func fetchTopRatedMovieList() {
        
        let params = MovieServiceParams()
        params.page = 1
        
        movieRepository
            .getTopRatedMovieList(params: params).subscribe(onNext: { [weak self] (topRatedMovieResponse) in
                if let topRatedMovieList = topRatedMovieResponse.results {
                    self?.delegate?.handleOutput(.showTopRatedMovies(topRatedMovieList))
                }
            }, onError: { [weak self] (error) in
                print("(getTopRatedMovieList) Hata oluştu:\(error.localizedDescription)")
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: fetchNowPlayingMovieList
    func fetchNowPlayingMovieList() {
      
      let params = MovieServiceParams()
      params.page = 1
        
        movieRepository
          .getNowPlayingMovieList(params: params).subscribe(onNext: { [weak self] (nowPlayingMovieResponse) in
              if let nowPlayingMovieList = nowPlayingMovieResponse.results {
                self?.delegate?.handleOutput(.showNowPlayingMovies(nowPlayingMovieList))
              }
        }, onError: { [weak self] (error) in
            print("(getNowPlayingMovieList) Hata oluştu:\(error.localizedDescription)")
        })
        .disposed(by: disposeBag)
    }
    
    // MARK: fetchPopularMovieList
    func fetchPopularMovieList() {
      
      let params = MovieServiceParams()
      params.page = 1
        
        movieRepository
          .getPopularMovieList(params: params).subscribe(onNext: { [weak self] (popularMovieResponse) in
            if let popularMovieList = popularMovieResponse.results {
              self?.delegate?.handleOutput(.showPopularMovies(popularMovieList))
            }
        }, onError: { [weak self] (error) in
            print("(fetchPopularMovieList) Hata oluştu:\(error.localizedDescription)")
        })
        .disposed(by: disposeBag)
    }
    
    func selectMovie(movie: MovieResult) {
        delegate?.handleOutput(.showMovieDetail(movie))
    }
    
}
