//
//  URLPaths.swift
//  MovieDBAPI
//
//  Created by Kaan Ozdemir on 22.10.2020.
//

import Foundation

struct URLPath {
    // MARK: Movie URLs
    static let topRatedMovies = "/\(Config.apiVersion)/movie/top_rated"
    static let nowPlayingMovies = "/\(Config.apiVersion)/movie/now_playing"
    static let popularMovies = "/\(Config.apiVersion)/movie/popular"

    // MARK: TV Serie URLs
    static let topRatedTVSeries = "/\(Config.apiVersion)/tv/top_rated"
    static let popularTVSeries = "/\(Config.apiVersion)/tv/popular"

    // MARK: Movie Genre URL
    static let movieGenres = "/\(Config.apiVersion)/genre/movie/list"
    static let tvSerieGenres = "/\(Config.apiVersion)/genre/tv/list"
}
