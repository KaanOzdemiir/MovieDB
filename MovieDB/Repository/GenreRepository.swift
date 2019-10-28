//
//  GenreRepository.swift
//  MovieDB
//
//  Created by Kaan Ozdemir on 27.10.2019.
//  Copyright © 2019 Kaan Ozdemir. All rights reserved.
//

import Foundation
import RxSwift

class GenreRepository {
    
    func getMovieGenreList() {
        AlamofireService.getMovieGenres(completion: { (response) in
            
            if let error = response.error {
                print("‼️ Failed. (getMovieGenres) *-> Error: ", error.localizedDescription)
                return
            }
            
            if let genres = response.result.value?.genres {
                ApplicationVariables.movieGenreList = genres
            }
        })
    }
    
    func getTVSerieGenreList() {
        AlamofireService.getTVSerieGenres(completion: { (response) in
            
            if let error = response.error {
                print("‼️ Failed. (getTVSerieGenres) *-> Error: ", error.localizedDescription)
                return
            }
            
            if let genres = response.result.value?.genres {
                ApplicationVariables.tvSerieGenreList = genres
            }
        })
    }
}

