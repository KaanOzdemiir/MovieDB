//
//  TVSerieData.swift
//  MovieDB
//
//  Created by Kaan Ozdemir on 27.10.2019.
//  Copyright © 2019 Kaan Ozdemir. All rights reserved.
//

import Foundation
import ObjectMapper

// MARK: - TVSerieResult
class TVSerieResult: Mappable {
    var originalName: String?
    var genreids: [Int]?
    var name: String?
    var popularity: Double?
    var originCountry: [String]?
    var voteCount: Int?
    var firstAirDate, backdropPath: String?
    var originalLanguage: String?
    var id: Int?
    var voteAverage: Double?
    var overview, posterPath: String?

    init(
        originalName: String? = nil,
        genreids: [Int]? = nil,
        name: String? = nil,
        popularity: Double? = nil,
        originCountry: [String]? = nil,
        voteCount: Int? = nil,
        firstAirDate: String? = nil,
        backdropPath: String? = nil,
        originalLanguage: String? = nil,
        id: Int? = nil,
        voteAverage: Double? = nil,
        overview: String? = nil,
        posterPath: String? = nil
    ) {
        self.originalName = originalName
        self.genreids = genreids
        self.name = name
        self.popularity = popularity
        self.originCountry = originCountry
        self.voteCount = voteCount
        self.firstAirDate = firstAirDate
        self.backdropPath = backdropPath
        self.originalLanguage = originalLanguage
        self.id = id
        self.voteAverage = voteAverage
        self.overview = overview
        self.posterPath = posterPath
    }
    
    func mapping(map: Map) {
        originalName <- map["original_name"]
        genreids <- map["genre_ids"]
        name <- map["name"]
        popularity <- map["popularity"]
        
        originCountry <- map["origin_country"]
        voteCount <- map["vote_count"]
        firstAirDate <- map["first_air_date"]
        backdropPath <- map["backdrop_path"]
        
        originalLanguage <- map["original_language"]
        id <- map["id"]
        voteAverage <- map["vote_average"]
        overview <- map["overview"]
        
        posterPath <- map["poster_path"]
    }
    
    required init?(map: Map) {
    }
}

