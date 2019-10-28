//
//  URLPaths.swift
//  MovieDB
//
//  Created by Kaan Ozdemir on 26.10.2019.
//  Copyright © 2019 Kaan Ozdemir. All rights reserved.
//

import Foundation

struct URLPath {
    // MARK: Movie URLs
    static let topRatedMovies = "/\(ApplicationConfig.apiVersion)/movie/top_rated"
    static let nowPlayingMovies = "/\(ApplicationConfig.apiVersion)/movie/now_playing"
    static let popularMovies = "/\(ApplicationConfig.apiVersion)/movie/popular"

    // MARK: TV Serie URLs
    static let topRatedTVSeries = "/\(ApplicationConfig.apiVersion)/tv/top_rated"
    static let popularTVSeries = "/\(ApplicationConfig.apiVersion)/tv/popular"

    // MARK: Movie Genre URL
    static let movieGenres = "/\(ApplicationConfig.apiVersion)/genre/movie/list"
    static let tvSerieGenres = "/\(ApplicationConfig.apiVersion)/genre/tv/list"
}
