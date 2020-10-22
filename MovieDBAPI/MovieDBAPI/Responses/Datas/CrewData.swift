//
//  CrewData.swift
//  MovieDBAPI
//
//  Created by Kaan Ozdemir on 22.10.2020.
//

import Foundation
import ObjectMapper

// MARK: - CrewData
public class CrewData: Mappable {
    public var creditid: String?
    public var department: String?
    public var id: Int?
    public var name: String?
    public var gender: Int?
    public var job: String?
    public var profilePath: String?

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
    
    public func mapping(map: Map) {
        creditid <- map["credit_id"]
        department <- map["department"]
        id <- map["id"]
        name <- map["name"]
        
        gender <- map["gender"]
        profilePath <- map["profile_path"]
        job <- map["job"]
    }
    
    required public init?(map: Map) {
    }
}
