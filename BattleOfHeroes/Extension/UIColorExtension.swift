//
//  UIColorExtension.swift
//  BattleOfHeroes
//
//  Created by Mark on 7/5/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import UIKit
import MDCCommon

extension UIColor {
    
    struct GameColors {        
        static let red = UIColor.init(hexString: "#FF6978")
        static let green = UIColor.init(hexString: "#BCE784")
        static let blue = UIColor.init(hexString: "#B1DDF1")
        
        static let backgroudColor = UIColor.init(hexString: "#f6dddf")
        static let activButton = UIColor.init(hexString: "#04bfbf")
        static let lightBule = UIColor.init(hexString: "#10c8cd")
        static let lightYellow = UIColor.init(hexString: "#f7e967")
        static let lightOrage = UIColor.init(hexString: "#f4977a")
    }
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
