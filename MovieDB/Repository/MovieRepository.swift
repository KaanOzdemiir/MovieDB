//
//  MovieRepository.swift
//  MovieDB
//
//  Created by Kaan Ozdemir on 26.10.2019.
//  Copyright © 2019 Kaan Ozdemir. All rights reserved.
//

import Foundation
import RxSwift

class MovieRespository {
    
    func getTopRatedMovieList(params: TopRatedMovieServiceParams) -> Observable<TopRatedMovieResponse> {
        return Observable.create({ observer -> Disposable in
            
            AlamofireService.getTopRatedMovies(params: params, completion: { (response) in
                
                if let error = response.error {
                    print("‼️ Failed. (getTopRatedMovies) *-> Error: ", error.localizedDescription)
                    observer.onError(error)
                    return
                }
                
                observer.onNext(response.result.value!)
                observer.onCompleted()
            })
            return Disposables.create()
        })
    }
}
