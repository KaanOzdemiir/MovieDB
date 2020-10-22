//
//  MoviesRouter.swift
//  MovieDBVIPER
//
//  Created by Kaan Ozdemir on 11.09.2020.
//  Copyright © 2020 Kaan Ozdemir. All rights reserved.
//

import Foundation
import UIKit
import MovieDBAPI

class MoviesRouter: MoviesRouterProtocol {
    
    unowned let view: UIViewController
    
    init(view: UIViewController) {
        self.view = view
    }
    
    func navigate(to route: MoviesRoute) {
        
        switch route {
        case .detail(let movie):
            let detailView = MovieDetailBuilder.make(with: movie)
            view.show(detailView, sender: nil)
        }
    }
}
