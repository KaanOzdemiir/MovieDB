//
//  MoviesPresenter.swift
//  MovieDBVIPER
//
//  Created by Kaan Ozdemir on 11.09.2020.
//  Copyright © 2020 Kaan Ozdemir. All rights reserved.
//

import Foundation

final class MoviesPresenter: MoviesPresenterProtocol {
    
    private let view: MoviesViewProtocol!
    private let interactor: MoviesInteractorProtocol!
    private let router: MoviesRouter!
    
    init(
        view: MoviesViewProtocol,
        interactor: MoviesInteractorProtocol,
        router: MoviesRouter
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
        interactor.delegate = self
    }
    
    func load() {
        view.handleOutput(.updateTitle("Movie Detail"))
        interactor.load()
    }
    
    func selectMovie(movie: MovieResult) {
        interactor.selectMovie(movie: movie)
    }
}

extension MoviesPresenter: MoviesInteractorDelegate {
    func handleOutput(_ output: MoviesInteractorOutput) {
        switch output {
        case .setLoading(let isLoading):
            view.handleOutput(.setLoading(isLoading))
        case .showTopRatedMovies(let movies):
            view.handleOutput(.showTopRatedMovies(movies))
        case .showNowPlayingMovies(let movies):
            view.handleOutput(.showNowPlayingMovies(movies))
        case .showPopularMovies(let movies):
            view.handleOutput(.showPopularMovies(movies))
        case .showMovieDetail(let movie):
            router.navigate(to: .detail(movie))
        }
    }
}
