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
    
    func getTopRatedMovieList(params: MovieServiceParams) -> Observable<MovieResponse> {
        return Observable.create({ observer -> Disposable in
            
            AlamofireService.getMovies(params: params, path: URLPath.topRatedMovies, completion: { (response) in
                
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
    
    func getNowPlayingMovieList(params: MovieServiceParams) -> Observable<MovieResponse> {
        return Observable.create({ observer -> Disposable in
            
            AlamofireService.getMovies(params: params, path: URLPath.nowPlayingMovies, completion: { (response) in
                
                if let error = response.error {
                    print("‼️ Failed. (getNowPlayingMovieList) *-> Error: ", error.localizedDescription)
                    observer.onError(error)
                    return
                }
                
                observer.onNext(response.result.value!)
                observer.onCompleted()
            })
            return Disposables.create()
        })
    }
    
    func getPopularMovieList(params: MovieServiceParams) -> Observable<MovieResponse> {
        return Observable.create({ observer -> Disposable in
            
            AlamofireService.getMovies(params: params, path: URLPath.popularMovies, completion: { (response) in
                
                if let error = response.error {
                    print("‼️ Failed. (getPopularMovieList) *-> Error: ", error.localizedDescription)
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
