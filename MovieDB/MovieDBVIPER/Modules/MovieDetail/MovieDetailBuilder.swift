//
//  MovieDetailRouter.swift
//  MovieDB
//
//  Created by Kaan Ozdemir on 21.10.2020.
//  Copyright © 2020 Kaan Ozdemir. All rights reserved.
//

import Foundation
import UIKit
import MovieDBAPI

final class MovieDetailBuilder{
    static func make(with movie: MovieData) -> MovieDetailVC {
        let storyBoard = UIStoryboard(name: "MovieDetail", bundle: nil)
        let view = storyBoard.instantiateViewController(withIdentifier: "MovieDetailVC") as! MovieDetailVC
        let interactor = MovieDetailInteractor(service: app.service)
        view.presenter = MovieDetailPresenter(view: view, interactor: interactor, movie: movie)
        return view
    }
}
