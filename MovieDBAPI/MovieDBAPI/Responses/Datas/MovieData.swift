//
//  MovieData.swift
//  MovieDBAPI
//
//  Created by Kaan Ozdemir on 22.10.2020.
//

import Foundation
import ObjectMapper

// MARK: - MovieData
public class MovieData: Mappable {
    public var popularity: Double?
    public var voteCount: Int?
    public var video: Bool?
    public var posterPath: String?
    public var id: Int?
    public var adult: Bool?
    public var backdropPath, originalLanguage, originalTitle: String?
    public var genreids: [Int]?
    public var title: String?
    public var voteAverage: Double?
    public var overview, releaseDate: String?

    public init(
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
    
    public func mapping(map: Map) {
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
    
    public required init?(map: Map) {
    }
}
