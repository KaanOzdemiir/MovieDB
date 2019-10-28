//
//  CastData.swift
//  MovieDB
//
//  Created by Kaan Ozdemir on 27.10.2019.
//  Copyright © 2019 Kaan Ozdemir. All rights reserved.
//

import Foundation
import ObjectMapper

// MARK: - CastData
class CastData: Mappable {
    var character, creditid: String?
    var id: Int?
    var name: String?
    var gender: Int?
    var profilePath: String?
    var order: Int?

    init(
        character: String? = nil,
        creditid: String? = nil,
        id: Int? = nil,
        name: String? = nil,
        gender: Int? = nil,
        profilePath: String? = nil,
        order: Int? = nil
    ) {
        self.character = character
        self.creditid = creditid
        self.id = id
        self.name = name
        self.gender = gender
        self.profilePath = profilePath
        self.order = order
    }
    
    func mapping(map: Map) {
        character <- map["character"]
        creditid <- map["credit_id"]
        id <- map["id"]
        name <- map["name"]
        
        gender <- map["gender"]
        profilePath <- map["profile_path"]
        order <- map["order"]
    }
    
    required init?(map: Map) {
    }
}
