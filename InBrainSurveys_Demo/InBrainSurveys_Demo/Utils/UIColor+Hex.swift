//
//  UIColor+Hex.swift
//  InBrainSurveys_Demo
//
//  Created by Sergey Blazhko on 02.10.2020.
//  Copyright © 2020 InBrain. All rights reserved.
//

import UIKit

extension UIColor {
    class var mainColor: UIColor { UIColor(named: "AzureColor") ?? .clear }
    
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        let scanner = Scanner(string: hex)

        if hex.hasPrefix("#") {
            if #available(iOS 13.0, *) {
                let startIndex = hex.startIndex
                scanner.currentIndex = hex.index(after: startIndex)
            } else {
                scanner.scanLocation = 1
            }
        }

        var color: UInt64 = 0
        scanner.scanHexInt64(&color)

        let mask = 0x0000_00FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask

        let red = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue = CGFloat(b) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

}
