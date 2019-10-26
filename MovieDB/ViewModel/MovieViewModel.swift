//
//  MovieViewModel.swift
//  MovieDB
//
//  Created by Kaan Ozdemir on 26.10.2019.
//  Copyright © 2019 Kaan Ozdemir. All rights reserved.
//

import Foundation
import RxSwift

class MovieViewModel {
    
    let disposeBag = DisposeBag()
    
    let movieRepository = MovieRespository()
    
    let topRatedMovieResponse = PublishSubject<MovieResponse>()
    
    var topRatedMovieList: [MovieResult] = []
    
    let nowPlayingMovieResponse = PublishSubject<MovieResponse>()
    
    var nowPlayingMovieList: [MovieResult] = []
    
    func fetchTopRatedMovieList() {
        
        let params = MovieServiceParams()
        params.page = 1
          
          movieRepository
            .getTopRatedMovieList(params: params).subscribe(onNext: { [weak self] (topRatedMovieResponse) in
                
                if let topRatedMovieList = topRatedMovieResponse.results {
                    self?.topRatedMovieList = topRatedMovieList
                }
              self?.topRatedMovieResponse.onNext(topRatedMovieResponse)
              
          }, onError: { [weak self] (error) in
              self?.topRatedMovieResponse.onError(error)
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
                  self?.nowPlayingMovieList = nowPlayingMovieList
              }
            self?.nowPlayingMovieResponse.onNext(nowPlayingMovieResponse)
            
        }, onError: { [weak self] (error) in
            self?.nowPlayingMovieResponse.onError(error)
        })
        .disposed(by: disposeBag)
    }
}
