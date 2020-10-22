//
//  CrewData.swift
//  MovieDBAPI
//
//  Created by Kaan Ozdemir on 22.10.2020.
//

import Foundation
import ObjectMapper

// MARK: - CastData
public class CastData: Mappable {
    public var character, creditid: String?
    public var id: Int?
    public var name: String?
    public var gender: Int?
    public var profilePath: String?
    public var order: Int?

    public init(
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
    
    public func mapping(map: Map) {
        character <- map["character"]
        creditid <- map["credit_id"]
        id <- map["id"]
        name <- map["name"]
        
        gender <- map["gender"]
        profilePath <- map["profile_path"]
        order <- map["order"]
    }
    
    required public init?(map: Map) {
    }
}
