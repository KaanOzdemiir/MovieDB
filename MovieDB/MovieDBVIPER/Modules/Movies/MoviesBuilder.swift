//
//  MoviesBuilder.swift
//  MovieDB
//
//  Created by Kaan Ozdemir on 11.09.2020.
//  Copyright © 2020 Kaan Ozdemir. All rights reserved.
//

import UIKit

final class MoviesBuilder {
    
    static func make() -> MoviesVC {
        let storyboard = UIStoryboard(name: "Movies", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "MoviesVC") as! MoviesVC
        let router = MoviesRouter(view: view)
        let interactor = MoviesInteractor(service: app.service)
        view.presenter = MoviesPresenter(view: view, interactor: interactor, router: router)
        return view
    }
}
