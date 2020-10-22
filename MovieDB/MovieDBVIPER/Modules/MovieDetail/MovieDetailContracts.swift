//
//  MovieDetailContracts.swift
//  MovieDB
//
//  Created by Kaan Ozdemir on 21.10.2020.
//  Copyright © 2020 Kaan Ozdemir. All rights reserved.
//

import Foundation
import MovieDBAPI

// MARK: Presenter

protocol MovieDetailPresenterProtocol: class {
    func load()
}

enum MovieDetailPresenterOutput {
    case updateTitle(String)
    case setLoading(Bool)
    case showMovie(MovieData)
    case showCrew([CrewData])
    case showCast([CastData])
}

// MARK: View

protocol MovieDetailViewProtocol: class {
    func handleOutput(_ output: MovieDetailPresenterOutput)
}

// MARK: Router
enum MovieDetailRouter: Equatable {
    
}

// MARK: Interactor
protocol MovieDetailInteractorProtocol: class {
    var delegate: MovieDetailInteractorDelegate? {get set}
    func load(movie: MovieData)
    func selectMovie(movie: MovieData)
}

protocol MovieDetailInteractorDelegate: class {
    func handleOutput(_ output: MovieDetailInteractorOutput)
}

enum MovieDetailInteractorOutput {
    case setLoading(Bool)
    case showMovies([MovieData])
    case showMovieDetail(MovieData)
    case showCrew([CrewData])
    case showCast([CastData])
}
