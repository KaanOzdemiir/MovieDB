//
//  MoviesContracts.swift
//  MovieDBVIPER
//
//  Created by Kaan Ozdemir on 11.09.2020.
//  Copyright © 2020 Kaan Ozdemir. All rights reserved.
//

import Foundation
import MovieDBAPI

// MARK: Presenter

protocol MoviesPresenterProtocol: class {
    func load()
    func selectMovie(movie: MovieData)
}

enum MoviesPresenterOutput {
    case updateTitle(String)
    case setLoading(Bool)
    case showTopRatedMovies([MovieData])
    case showNowPlayingMovies([MovieData])
    case showPopularMovies([MovieData])
}

// MARK: View
protocol MoviesViewProtocol: class {
    func handleOutput(_ output: MoviesPresenterOutput)
}

// MARK: Router
enum MoviesRoute {
    case detail(MovieData)
}

protocol MoviesRouterProtocol: class {
    func navigate(to route: MoviesRoute)
}

// MARK: Interactor
protocol MoviesInteractorProtocol: class {
    var delegate: MoviesInteractorDelegate? {get set}
    func load()
    func selectMovie(movie: MovieData)
}

protocol MoviesInteractorDelegate: class {
    func handleOutput(_ output: MoviesInteractorOutput)
}

enum MoviesInteractorOutput {
    case setLoading(Bool)
    case showTopRatedMovies([MovieData])
    case showNowPlayingMovies([MovieData])
    case showPopularMovies([MovieData])
    case showMovieDetail(MovieData)
}
