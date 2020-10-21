//
//  MovieDetailContracts.swift
//  MovieDB
//
//  Created by Kaan Ozdemir on 21.10.2020.
//  Copyright © 2020 Kaan Ozdemir. All rights reserved.
//

import Foundation

// MARK: Presenter

protocol MovieDetailPresenterProtocol: class {
    func load()
}

enum MovieDetailPresenterOutput {
    case updateTitle(String)
    case setLoading(Bool)
    case showMovie(MovieResult)
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
    func load(movie: MovieResult)
    func selectMovie(movie: MovieResult)
}

protocol MovieDetailInteractorDelegate: class {
    func handleOutput(_ output: MovieDetailInteractorOutput)
}

enum MovieDetailInteractorOutput {
    case setLoading(Bool)
    case showMovies([MovieResult])
    case showMovieDetail(MovieResult)
    case showCrew([CrewData])
    case showCast([CastData])
}
