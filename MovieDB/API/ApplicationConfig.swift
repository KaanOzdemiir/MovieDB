//
//  ApplicationConfig.swift
//  MovieDB
//
//  Created by Kaan Ozdemir on 26.10.2019.
//  Copyright © 2019 Kaan Ozdemir. All rights reserved.
//

import Foundation

class ApplicationConfig {
    static var apiKey: String {
        get {
            return "8b0f3b3d203ed2dd5e3ff1349dd9489f"
        }
    }
    
    static var apiReadAccessToken: String {
        get {
            return "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4YjBmM2IzZDIwM2VkMmRkNWUzZmYxMzQ5ZGQ5NDg5ZiIsInN1YiI6IjVkYjQ0ODkyZDQwZDRjMDAxNGZiMDRhYiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.75Ys5Rpl2G6ihozTo1XXHsBRrKndcc30UN2uXzwEn2s"
        }
    }
    
    static var host: String {
        get {
            return "api.themoviedb.org"
        }
    }
    
    static var apiVersion: String {
        get {
            return "3"
        }
    }
    
    static var language: String {
        get {
            return "en-US"
        }
    }
}
