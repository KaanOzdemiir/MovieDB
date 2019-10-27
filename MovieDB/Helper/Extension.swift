//
//  Extension.swift
//  MovieDB
//
//  Created by Kaan Ozdemir on 26.10.2019.
//  Copyright © 2019 Kaan Ozdemir. All rights reserved.
//

import UIKit

extension String {
    var url: String {
        return "\(AlamofireService.urlScheme)://image.tmdb.org/t/p/w500/\(self)"
    }
}

extension Double {
    var stringValue: String {
        return "\(self)"
    }
}

extension UIView {
    func applyGradient(startColor: UIColor, endColor: UIColor) {
        let gradient = CAGradientLayer()
        gradient.colors = [startColor.cgColor,
                           endColor.cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.frame = self.bounds
        gradient.cornerRadius = self.bounds.width / 2
        gradient.masksToBounds = true
        self.layer.insertSublayer(gradient, at: 0)
    }
}
