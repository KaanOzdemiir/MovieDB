//
//  MovieCreditsRepository.swift
//  MovieDB
//
//  Created by Kaan Ozdemir on 27.10.2019.
//  Copyright © 2019 Kaan Ozdemir. All rights reserved.
//

import Foundation
import RxSwift

class CreditsRepository {
    
    func getCrewAndCastList(urlPath path: String) -> Observable<CreditsResponse> {
        return Observable.create({ observer -> Disposable in
            
            AlamofireService.getCrewAndCast(urlPath: path, completion: { (response) in
                
                if let error = response.error {
                    print("‼️ Failed. (getCrewAndCast) *-> Error: ", error.localizedDescription)
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

