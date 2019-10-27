//
//  TVSerieResponse.swift
//  MovieDB
//
//  Created by Kaan Ozdemir on 27.10.2019.
//  Copyright © 2019 Kaan Ozdemir. All rights reserved.
//

import Foundation
import ObjectMapper

// MARK: - TVSerieResponse
class TVSerieResponse: Mappable {
    var page, totalResults, totalPages: Int?
    var results: [TVSerieResult]?
    
    init(
        page: Int? = nil,
        totalResults: Int? = nil,
        totalPages: Int? = nil,
        results: [TVSerieResult]? = nil
    ) {
        self.page = page
        self.totalResults = totalResults
        self.totalPages = totalPages
        self.results = results
    }
    
    func mapping(map: Map) {
        page <- map["page"]
        totalResults <- map["total_results"]
        totalPages <- map["total_pages"]
        results <- map["results"]

    }
    
    required init?(map: Map) {
    }
}

