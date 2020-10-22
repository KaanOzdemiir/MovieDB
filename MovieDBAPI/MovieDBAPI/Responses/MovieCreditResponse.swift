//
//  MovieCreditResponse.swift
//  MovieDBAPI
//
//  Created by Kaan Ozdemir on 22.10.2020.
//

import Foundation
import ObjectMapper

// MARK: - CreditsResponse
public class CreditsResponse: Mappable {
    public var cast: [CastData]?
    public var crew: [CrewData]?
    public var id: Int?

    public init(
        cast: [CastData]? = nil,
        crew: [CrewData]? = nil,
        id: Int? = nil
    ) {
        self.cast = cast
        self.crew = crew
        self.id = id
    }
    
    public func mapping(map: Map) {
        cast <- map["cast"]
        crew <- map["crew"]
        id <- map["id"]
    }
    
    required public init?(map: Map) {
    }
    
}
