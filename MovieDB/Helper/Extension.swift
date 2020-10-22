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
        return "https://image.tmdb.org/t/p/w500/\(self)"
    }
    
    func getLineSpacedAttributedText(lineSpacing: CGFloat = 0) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: self)

        let paragraphStyle = NSMutableParagraphStyle()

        paragraphStyle.lineSpacing = lineSpacing

        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        return attributedString
    }
}

extension UIViewController {
    var statusBarHeight: CGFloat{
        if #available(iOS 13.0, *) {
            return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0)
        } else {
            return UIApplication.shared.statusBarFrame.height
        }
    }
}

extension Array where Element == String {
    func getStringFromArraySeperatedByComa() -> String? {
        
        var str = ""
        self.forEach({ (stringData) in
            
            str = "\(str)\(stringData), "
        })
        
        if str.isEmpty {
            return nil
        }
        return "\(str.dropLast().dropLast())"
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

extension CustomStringConvertible{
    var description: String{
        var desc = "Class Name: \(type(of: self))\n"
        let mirror = Mirror(reflecting: self)
        for child in mirror.children {
            if let label = child.label {
                desc.append("\(label): \(child.value)\n")
            }
        }
        return desc
    }
}
