//
//  AlamofireService.swift
//  MovieDB
//
//  Created by Kaan Ozdemir on 26.10.2019.
//  Copyright © 2019 Kaan Ozdemir. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

class AlamofireService {
        
    static let defaultHeaderParams = [
        "accept": "application/json",
        "apikey": ApplicationConfig.apiKey
    ]
    
    static var urlScheme: String {
        get {
            return "https"
        }
    }
    
    static func getMovies(params: MovieServiceParams, path: String, completion: @escaping (DataResponse<MovieResponse>) -> ()) {
        
        var urlComponents = URLComponents()
        urlComponents.host = ApplicationConfig.host
        urlComponents.path = path
        urlComponents.scheme = urlScheme
        
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: ApplicationConfig.apiKey),
            URLQueryItem(name: "language", value: ApplicationConfig.language),
            URLQueryItem(name: "page", value: "\(params.page)")
        ]
        
        if let region = params.region, !region.isEmpty {
            urlComponents.queryItems?.append(
                URLQueryItem(name: "region", value: params.region)
            )
        }
        
        print("\n\(urlComponents.string!) istek atılıyor...")
        Alamofire.request(urlComponents.string!, method: .get, encoding: URLEncoding.default, headers: defaultHeaderParams)
            .validate(statusCode: 200..<600)
            .responseObject { (response: DataResponse<MovieResponse>) in
            
            print(response.result.value)
            completion(response)
        }
            .responseJSON { response in
                print("JSON:\(response.result.value)")
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        print(data)
                    }
                    
                case .failure(_):
                    
                    print("Error message:\(response.result.error)")
                    break
                    
                }
        }
    }
}
