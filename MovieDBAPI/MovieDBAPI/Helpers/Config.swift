//
//  Config.swift
//  MovieDBAPI
//
//  Created by Kaan Ozdemir on 22.10.2020.
//

import Foundation

public class Config {
    static var apiKey: String {
        get {
            return "8b0f3b3d203ed2dd5e3ff1349dd9489f"
        }
    }
    
    public static var apiReadAccessToken: String {
        get {
            return "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4YjBmM2IzZDIwM2VkMmRkNWUzZmYxMzQ5ZGQ5NDg5ZiIsInN1YiI6IjVkYjQ0ODkyZDQwZDRjMDAxNGZiMDRhYiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.75Ys5Rpl2G6ihozTo1XXHsBRrKndcc30UN2uXzwEn2s"
        }
    }
    
    public static var host: String {
        get {
            return "api.themoviedb.org"
        }
    }
    
    public static var apiVersion: String {
        get {
            return "3"
        }
    }
    
    public static var language: String {
        get {
            return "en-US"
        }
    }
}
