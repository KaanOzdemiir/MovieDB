//
//  Result.swift
//  MovieDBAPI
//
//  Created by Kaan Ozdemir on 22.10.2020.
//

import Foundation

public enum Result<T>{
    case success(T)
    case failure(Error?)
}
