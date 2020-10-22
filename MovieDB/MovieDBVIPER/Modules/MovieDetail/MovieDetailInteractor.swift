//
//  MovieDetailInteractor.swift
//  MovieDB
//
//  Created by Kaan Ozdemir on 21.10.2020.
//  Copyright © 2020 Kaan Ozdemir. All rights reserved.
//

import Foundation
import RxSwift
import MovieDBAPI

class MovieDetailInteractor: MovieDetailInteractorProtocol {
    var delegate: MovieDetailInteractorDelegate?

    let disposeBag = DisposeBag()
    var service: APIService
    init(service: APIService) {
        self.service = service
    }
    
    func load(movie: MovieData) {
        delegate?.handleOutput(.setLoading(true))
        delegate?.handleOutput(.showMovieDetail(movie))
        
        guard let movieId = movie.id else { return }
        fetchMovieCharacterList(movieId: movieId)
    }

    func selectMovie(movie: MovieData) {
        delegate?.handleOutput(.showMovieDetail(movie))
        
    }

    func fetchMovieCharacterList(movieId id: Int) {
        service.getCredits(id: "\(id)", params: [:]) { [weak self] (result) in
            switch result{
            case .success(let response):
                if let crewList = response?.crew {
                    self?.delegate?.handleOutput(.showCrew(crewList))
                    self?.delegate?.handleOutput(.setLoading(false))
                }
                
                if let castList = response?.cast {
                    self?.delegate?.handleOutput(.showCast(castList))
                    self?.delegate?.handleOutput(.setLoading(false))
                }
            case .failure(let error):
                print(error?.localizedDescription)
            }
        }
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
