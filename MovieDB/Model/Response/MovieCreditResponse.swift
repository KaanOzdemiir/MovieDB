//
//  MovieCreditResponse.swift
//  MovieDB
//
//  Created by Kaan Ozdemir on 27.10.2019.
//  Copyright © 2019 Kaan Ozdemir. All rights reserved.
//

import Foundation
import ObjectMapper

// MARK: - CreditsResponse
class CreditsResponse: Mappable {
    var cast: [CastData]?
    var crew: [CrewData]?
    var id: Int?

    init(
        cast: [CastData]? = nil,
        crew: [CrewData]? = nil,
        id: Int? = nil
    ) {
        self.cast = cast
        self.crew = crew
        self.id = id
    }
    
    func mapping(map: Map) {
        cast <- map["cast"]
        crew <- map["crew"]
        id <- map["id"]
    }
    
    required init?(map: Map) {
    }
    
}
