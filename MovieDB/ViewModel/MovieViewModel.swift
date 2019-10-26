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
    
    let topRatedMovieResponse = PublishSubject<TopRatedMovieResponse>()
    
    var topRatedMovieList: [TopRatedMovieResult] = []
    
    func fetchTopRatedMovieList() {
        
        let params = TopRatedMovieServiceParams()
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
}
