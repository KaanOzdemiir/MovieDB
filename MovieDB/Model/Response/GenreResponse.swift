//
//  GenreResponse.swift
//  MovieDB
//
//  Created by Kaan Ozdemir on 27.10.2019.
//  Copyright © 2019 Kaan Ozdemir. All rights reserved.
//

import Foundation
import ObjectMapper

// MARK: - GenreResponse
class GenreResponse: Mappable {
    var genres: [GenreData]?

    init(genres: [GenreData]? = nil) {
        self.genres = genres
    }
    
    func mapping(map: Map) {
        genres <- map["genres"]
    }
    
    required init?(map: Map) {
    }
}
