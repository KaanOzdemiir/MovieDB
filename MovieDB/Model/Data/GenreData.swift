//
//  GenreData.swift
//  MovieDB
//
//  Created by Kaan Ozdemir on 27.10.2019.
//  Copyright © 2019 Kaan Ozdemir. All rights reserved.
//

import Foundation
import ObjectMapper

// MARK: - MovieGenreData
class GenreData: Mappable {
    var id: Int?
    var name: String?

    init(
        id: Int? = nil,
        name: String? = nil
    ) {
        self.id = id
        self.name = name
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
    
    required init?(map: Map) {
    }
}
