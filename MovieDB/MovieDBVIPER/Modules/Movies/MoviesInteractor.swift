//
//  MoviesInteractor.swift
//  MovieDB
//
//  Created by Kaan Ozdemir on 21.10.2020.
//  Copyright © 2020 Kaan Ozdemir. All rights reserved.
//

import Foundation
import RxSwift
import MovieDBAPI

class MoviesInteractor: MoviesInteractorProtocol {
    weak var delegate: MoviesInteractorDelegate?
    
    var service: APIService
    init(service: APIService) {
        self.service = service
    }
    
    func load() {
        delegate?.handleOutput(.setLoading(true))
        fetchTopRatedMovieList()
        fetchNowPlayingMovieList()
        fetchPopularMovieList()
    }
    
    func fetchTopRatedMovieList() {
        
        let params: [String: Any] = [
            "page": "1"
        ]
        service.getTopRatedMovies(params: params) { (result) in
            switch result{
            case .success(let response):
                let movies = response?.results ?? []
                self.delegate?.handleOutput(.showTopRatedMovies(movies))
                self.delegate?.handleOutput(.setLoading(false))
            case .failure(let error): break
                
            }
        }
    }
    
    // MARK: fetchNowPlayingMovieList
    func fetchNowPlayingMovieList() {
        let params: [String: Any] = [
            "page": "1"
        ]
        service.getNowPlayingMovies(params: params) { (result) in
            switch result{
            case .success(let response):
                let movies = response?.results ?? []
                self.delegate?.handleOutput(.showNowPlayingMovies(movies))
                self.delegate?.handleOutput(.setLoading(false))
            case .failure(let error): break
                
            }
        }
    }
    
    // MARK: fetchPopularMovieList
    func fetchPopularMovieList() {
      
        let params: [String: Any] = [
            "page": "1"
        ]
        service.getPopularMovies(params: params) { (result) in
            switch result{
            case .success(let response):
                let movies = response?.results ?? []
                self.delegate?.handleOutput(.showPopularMovies(movies))
                self.delegate?.handleOutput(.setLoading(false))
            case .failure(let error): break
                
            }
        }
    }
    
    func selectMovie(movie: MovieData) {
        delegate?.handleOutput(.showMovieDetail(movie))
    }
    
}
