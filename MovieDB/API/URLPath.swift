//
//  URLPaths.swift
//  MovieDB
//
//  Created by Kaan Ozdemir on 26.10.2019.
//  Copyright © 2019 Kaan Ozdemir. All rights reserved.
//

import Foundation

struct URLPath {
    static let topRatedMovies = "/\(ApplicationConfig.apiVersion)/movie/top_rated"
    static let nowPlayingMovies = "/\(ApplicationConfig.apiVersion)/movie/now_playing"
    static let popularMovies = "/\(ApplicationConfig.apiVersion)/movie/popular"

}
