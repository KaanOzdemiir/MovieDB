//
//  MovieResponse.swift
//  MovieDBAPI
//
//  Created by Kaan Ozdemir on 22.10.2020.
//

import Foundation
import ObjectMapper

// MARK: - MovieResponse
public class MovieResponse: Mappable {
    public var page, totalResults, totalPages: Int?
    public var results: [MovieData]?
    
    public init(
        page: Int? = nil,
        totalResults: Int? = nil,
        totalPages: Int? = nil,
        results: [MovieData]? = nil
    ) {
        self.page = page
        self.totalResults = totalResults
        self.totalPages = totalPages
        self.results = results
    }
    
    public func mapping(map: Map) {
        page <- map["page"]
        totalResults <- map["total_results"]
        totalPages <- map["total_pages"]
        results <- map["results"]

    }
    
    public required init?(map: Map) {
    }
}

