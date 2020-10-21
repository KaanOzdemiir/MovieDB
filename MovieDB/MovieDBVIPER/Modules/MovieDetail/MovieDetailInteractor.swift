//
//  MovieDetailInteractor.swift
//  MovieDB
//
//  Created by Kaan Ozdemir on 21.10.2020.
//  Copyright © 2020 Kaan Ozdemir. All rights reserved.
//

import Foundation
import RxSwift

class MovieDetailInteractor: MovieDetailInteractorProtocol {
    var delegate: MovieDetailInteractorDelegate?

    let disposeBag = DisposeBag()
    let creditsRepository = CreditsRepository()
    
    init() {
    }
    func load(movie: MovieResult) {
        delegate?.handleOutput(.setLoading(true))
        delegate?.handleOutput(.showMovieDetail(movie))
        
        guard let movieId = movie.id else { return }
        fetchMovieCharacterList(movieId: movieId)
    }

    func selectMovie(movie: MovieResult) {
        delegate?.handleOutput(.showMovieDetail(movie))
        
    }

    func fetchMovieCharacterList(movieId id: Int) {
        
        let urlPath = "/\(ApplicationConfig.apiVersion)/movie/\(id)/credits"
        
        creditsRepository
            .getCrewAndCastList(urlPath: urlPath).subscribe(onNext: { [weak self] (creditsResponse) in
                
                if let crewList = creditsResponse.crew {
                    self?.delegate?.handleOutput(.showCrew(crewList))
                }
                
                if let castList = creditsResponse.cast {
                    self?.delegate?.handleOutput(.showCast(castList))
                }
                
                }, onError: { [weak self] (error) in
                    print("(getCrewAndCastList) Hata oluştu:\(error.localizedDescription)")
            })
            .disposed(by: disposeBag)
    }
//
//    func fetchTVSerieCharacterList(tvSerieId id: Int) {
//
//        let urlPath = "/\(ApplicationConfig.apiVersion)/tv/\(id)/credits"
//
//        creditsRepository
//            .getCrewAndCastList(urlPath: urlPath).subscribe(onNext: { [weak self] (tvSerieCreditsResponse) in
//
//                if let tvSerieCrewList = tvSerieCreditsResponse.crew {
//                    self?.crewList = tvSerieCrewList
//                }
//
//                if let movieCastList = tvSerieCreditsResponse.cast {
//                    self?.castList = movieCastList
//                }
//                self?.creditsResponse.onNext(tvSerieCreditsResponse)
//
//                }, onError: { [weak self] (error) in
//                    self?.creditsResponse.onError(error)
//            })
//            .disposed(by: disposeBag)
//    }
}
