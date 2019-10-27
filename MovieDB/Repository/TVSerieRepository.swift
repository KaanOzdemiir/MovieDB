//
//  TVSerieRepository.swift
//  MovieDB
//
//  Created by Kaan Ozdemir on 27.10.2019.
//  Copyright © 2019 Kaan Ozdemir. All rights reserved.
//

import Foundation
import RxSwift

class TVSerieRepository {
    
    func getTopRatedTVSerieList(params: TVSerieServiceParams) -> Observable<TVSerieResponse> {
        return Observable.create({ observer -> Disposable in
            
            AlamofireService.getTVSeries(params: params, path: URLPath.topRatedTVSeries, completion: { (response) in
                
                if let error = response.error {
                    print("‼️ Failed. (getTVSeries) *-> Error: ", error.localizedDescription)
                    observer.onError(error)
                    return
                }
                
                observer.onNext(response.result.value!)
                observer.onCompleted()
            })
            return Disposables.create()
        })
    }
    
    func getPopularTVSerieList(params: TVSerieServiceParams) -> Observable<TVSerieResponse> {
        return Observable.create({ observer -> Disposable in
            
            AlamofireService.getTVSeries(params: params, path: URLPath.popularTVSeries, completion: { (response) in
                
                if let error = response.error {
                    print("‼️ Failed. (getTVSeries) *-> Error: ", error.localizedDescription)
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
