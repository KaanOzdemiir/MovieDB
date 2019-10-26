//
//  TopRatedMovieData.swift
//  MovieDB
//
//  Created by Kaan Ozdemir on 26.10.2019.
//  Copyright © 2019 Kaan Ozdemir. All rights reserved.
//

import Foundation
import ObjectMapper

// MARK: - MovieResult
class MovieResult: Mappable {
    var popularity: Double?
    var voteCount: Int?
    var video: Bool?
    var posterPath: String?
    var id: Int?
    var adult: Bool?
    var backdropPath, originalLanguage, originalTitle: String?
    var genreids: [Int]?
    var title: String?
    var voteAverage: Double?
    var overview, releaseDate: String?

    init(
        popularity: Double? = nil,
        voteCount: Int? = nil,
        video: Bool? = nil,
        posterPath: String? = nil,
        id: Int? = nil,
        adult: Bool? = nil,
        backdropPath: String? = nil,
        originalLanguage: String? = nil,
        originalTitle: String? = nil,
        genreids: [Int]? = nil,
        title: String? = nil,
        voteAverage: Double? = nil,
        overview: String? = nil,
        releaseDate: String? = nil
    ) {
        self.popularity = popularity
        self.voteCount = voteCount
        self.video = video
        self.posterPath = posterPath
        self.id = id
        self.adult = adult
        self.backdropPath = backdropPath
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.genreids = genreids
        self.title = title
        self.voteAverage = voteAverage
        self.overview = overview
        self.releaseDate = releaseDate
    }
    
    func mapping(map: Map) {
        popularity <- map["popularity"]
        voteCount <- map["vote_count"]
        video <- map["video"]
        posterPath <- map["poster_path"]
        
        id <- map["id"]
        adult <- map["adult"]
        backdropPath <- map["backdrop_path"]
        originalLanguage <- map["original_language"]
        
        originalTitle <- map["original_title"]
        genreids <- map["genre_ids"]
        title <- map["title"]
        voteAverage <- map["vote_average"]
        
        overview <- map["overview"]
        releaseDate <- map["release_date"]
    }
    
    required init?(map: Map) {
    }
}
