//
//  APIService.swift
//  MovieDBAPI
//
//  Created by Kaan Ozdemir on 22.10.2020.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

public class APIService {
        
    let defaultHeaderParams = [
        "accept": "application/json",
        "apikey": Config.apiKey
    ]
    
    var urlScheme: String {
        get {
            return "https"
        }
    }
    
    public init () { }
    
    public func getTopRatedMovies(params: [String: Any], completion: @escaping (Result<MovieResponse?>) -> ()) {
        
        var urlComponents = URLComponents()
        urlComponents.host = Config.host
        urlComponents.path = URLPath.topRatedMovies
        urlComponents.scheme = urlScheme
        
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: Config.apiKey),
            URLQueryItem(name: "language", value: Config.language),
            URLQueryItem(name: "page", value: "\(1)")
        ]
        
//        if let region = params.region, !region.isEmpty {
//            urlComponents.queryItems?.append(
//                URLQueryItem(name: "region", value: "tr")
//            )
//        }
        
        print("\n\(urlComponents.string!) istek atılıyor...")
        Alamofire.request(urlComponents.string!, method: .get, encoding: URLEncoding.default, headers: defaultHeaderParams)
            .validate(statusCode: 200..<600)
            .responseObject { (response: DataResponse<MovieResponse>) in
                
                if let error = response.error{
                    completion(.failure(error))
                    return
                }
                completion(.success(response.value))
        }
    }
    
    public func getNowPlayingMovies(params: [String: Any], completion: @escaping (Result<MovieResponse?>) -> ()) {
        
        var urlComponents = URLComponents()
        urlComponents.host = Config.host
        urlComponents.path = URLPath.nowPlayingMovies
        urlComponents.scheme = urlScheme
        
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: Config.apiKey),
            URLQueryItem(name: "language", value: Config.language),
            URLQueryItem(name: "page", value: "\(1)")
        ]
        
//        if let region = params.region, !region.isEmpty {
//            urlComponents.queryItems?.append(
//                URLQueryItem(name: "region", value: "tr")
//            )
//        }
        
        print("\n\(urlComponents.string!) istek atılıyor...")
        Alamofire.request(urlComponents.string!, method: .get, encoding: URLEncoding.default, headers: defaultHeaderParams)
            .validate(statusCode: 200..<600)
            .responseObject { (response: DataResponse<MovieResponse>) in
                
                if let error = response.error{
                    completion(.failure(error))
                    return
                }
                completion(.success(response.value))
        }
    }
    
    public func getPopularMovies(params: [String: Any], completion: @escaping (Result<MovieResponse?>) -> ()) {
        
        var urlComponents = URLComponents()
        urlComponents.host = Config.host
        urlComponents.path = URLPath.popularMovies
        urlComponents.scheme = urlScheme
        
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: Config.apiKey),
            URLQueryItem(name: "language", value: Config.language),
            URLQueryItem(name: "page", value: "\(1)")
        ]
        
//        if let region = params.region, !region.isEmpty {
//            urlComponents.queryItems?.append(
//                URLQueryItem(name: "region", value: "tr")
//            )
//        }
        
        print("\n\(urlComponents.string!) istek atılıyor...")
        Alamofire.request(urlComponents.string!, method: .get, encoding: URLEncoding.default, headers: defaultHeaderParams)
            .validate(statusCode: 200..<600)
            .responseObject { (response: DataResponse<MovieResponse>) in
                
                if let error = response.error{
                    completion(.failure(error))
                    return
                }
                completion(.success(response.value))
        }
    }
    
    public func getCredits(id: String, params: [String: Any], completion: @escaping (Result<CreditsResponse?>) -> ()) {
        
        var urlComponents = URLComponents()
        urlComponents.host = Config.host
        urlComponents.path = "/\(Config.apiVersion)/movie/\(id)/credits"
        urlComponents.scheme = urlScheme
        
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: Config.apiKey),
            URLQueryItem(name: "language", value: Config.language),
            URLQueryItem(name: "page", value: "\(1)")
        ]
        
//        if let region = params.region, !region.isEmpty {
//            urlComponents.queryItems?.append(
//                URLQueryItem(name: "region", value: "tr")
//            )
//        }
        
        print("\n\(urlComponents.string!) istek atılıyor...")
        Alamofire.request(urlComponents.string!, method: .get, encoding: URLEncoding.default, headers: defaultHeaderParams)
            .validate(statusCode: 200..<600)
            .responseObject { (response: DataResponse<CreditsResponse>) in
                
                if let error = response.error{
                    completion(.failure(error))
                    return
                }
                completion(.success(response.value))
        }
    }
}
