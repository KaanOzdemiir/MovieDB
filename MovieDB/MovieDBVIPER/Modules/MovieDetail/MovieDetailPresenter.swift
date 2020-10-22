//
//  MovieDetailPresenter.swift
//  MovieDB
//
//  Created by Kaan Ozdemir on 21.10.2020.
//  Copyright © 2020 Kaan Ozdemir. All rights reserved.
//

import Foundation
import MovieDBAPI

final class MovieDetailPresenter: MovieDetailPresenterProtocol {
    
    let view: MovieDetailViewProtocol!
    private let interactor: MovieDetailInteractorProtocol!
    private let movie: MovieData

    init(
        view: MovieDetailViewProtocol,
        interactor: MovieDetailInteractorProtocol,
        movie: MovieData
        ) {
        self.view = view
        self.interactor = interactor
        self.movie = movie
        interactor.delegate = self
    }
    
    func load() {
        interactor.load(movie: movie)
    }
    
}

extension MovieDetailPresenter: MovieDetailInteractorDelegate{
    func handleOutput(_ output: MovieDetailInteractorOutput) {
        switch output {
        case .setLoading(let isLoading):
            view.handleOutput(.setLoading(isLoading))
        case .showMovieDetail(let movie):
            view.handleOutput(.showMovie(movie))
        case .showCrew(let crew):
            view.handleOutput(.showCrew(crew))
        default:
            break
        }
    }
}
