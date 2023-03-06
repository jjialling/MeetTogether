//
//  UIColor + Extensions.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/2/9.
//

import UIKit

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        /// info: https://stackoverflow.com/a/58646503

        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }

        assert(hexFormatted.count == 6, "Invalid hex code used.")

        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}

extension UIColor {
    struct Neutral {
        /// #191919
        static let black = UIColor(hex: "#191919")
        /// #383838
        static let dark = UIColor(hex: "#383838")
        /// #767676
        static let secGrey = UIColor(hex: "#767676")
        /// #B2B2B2
        static let grey = UIColor(hex: "#B2B2B2")
        /// #E6E6E6
        static let lightGrey = UIColor(hex: "#E6E6E6")
        /// #F6F7F9
        static let whiteGrey = UIColor(hex: "#F6F7F9")
        /// #F2F2F2
        static let whiteStroke = UIColor(hex: "#F2F2F2")
    }
    struct Green {
        /// #6dcdb1
        static let lightGreen = UIColor(hex: "#6dcdb1")
        /// #4F7C0B
        static let secGreen = UIColor(hex: "#4F7C0B")
    }
    struct Blue {
        /// #3eb3e4
        static let lightBlue = UIColor(hex: "#3eb3e4")
        /// #14425A
        static let dark = UIColor(hex: "#14425A")
        
    }
}
