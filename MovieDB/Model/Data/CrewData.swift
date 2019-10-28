//
//  CrewData.swift
//  MovieDB
//
//  Created by Kaan Ozdemir on 27.10.2019.
//  Copyright © 2019 Kaan Ozdemir. All rights reserved.
//

import Foundation
import ObjectMapper

// MARK: - CrewData
class CrewData: Mappable {
    var creditid: String?
    var department: String?
    var id: Int?
    var name: String?
    var gender: Int?
    var job: String?
    var profilePath: String?

    init(
        creditid: String? = nil,
        department: String? = nil,
        id: Int? = nil,
        name: String? = nil,
        gender: Int? = nil,
        job: String? = nil,
        profilePath: String? = nil
    ) {
        self.creditid = creditid
        self.department = department
        self.id = id
        self.name = name
        self.gender = gender
        self.job = job
        self.profilePath = profilePath
    }
    
    func mapping(map: Map) {
        creditid <- map["credit_id"]
        department <- map["department"]
        id <- map["id"]
        name <- map["name"]
        
        gender <- map["gender"]
        profilePath <- map["profile_path"]
        job <- map["job"]
    }
    
    required init?(map: Map) {
    }
}
