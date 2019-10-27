//
//  TVSerieViewModel.swift
//  MovieDB
//
//  Created by Kaan Ozdemir on 27.10.2019.
//  Copyright © 2019 Kaan Ozdemir. All rights reserved.
//

import Foundation
import RxSwift

class TVSerieViewModel {
    
    let disposeBag = DisposeBag()
    
    let tvSerieRepository = TVSerieRepository()
    
    let tvSerieResponse = PublishSubject<TVSerieResponse>()
    
    var tvSerieList: [TVSerieResult] = []
    
    let popularTVSerieResponse = PublishSubject<TVSerieResponse>()
    
    var popularTVSerieList: [TVSerieResult] = []
    
    func fetchTopRatedTVSerieList() {
        
        let params = TVSerieServiceParams()
        params.page = 1
          
          tvSerieRepository
            .getTopRatedTVSerieList(params: params).subscribe(onNext: { [weak self] (tvSerieResponse) in
                
                if let tvSerieList = tvSerieResponse.results {
                    self?.tvSerieList = tvSerieList
                }
              self?.tvSerieResponse.onNext(tvSerieResponse)
              
          }, onError: { [weak self] (error) in
              self?.tvSerieResponse.onError(error)
          })
          .disposed(by: disposeBag)
      }
    
    func fetchPopularTVSerieList() {
      
      let params = TVSerieServiceParams()
      params.page = 1
        
        tvSerieRepository
          .getPopularTVSerieList(params: params).subscribe(onNext: { [weak self] (popularTVSerieResponse) in
              
              if let popularTVSerieList = popularTVSerieResponse.results {
                  self?.popularTVSerieList = popularTVSerieList
              }
            self?.popularTVSerieResponse.onNext(popularTVSerieResponse)
            
        }, onError: { [weak self] (error) in
            self?.popularTVSerieResponse.onError(error)
        })
        .disposed(by: disposeBag)
    }
}

