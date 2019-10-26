//
//  Extension.swift
//  MovieDB
//
//  Created by Kaan Ozdemir on 26.10.2019.
//  Copyright © 2019 Kaan Ozdemir. All rights reserved.
//

import UIKit

extension String {
    var posterUrl: String {
        return "\(AlamofireService.urlScheme)://image.tmdb.org/t/p/w500/\(self)"
    }
}
