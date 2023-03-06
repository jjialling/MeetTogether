//
//  NSMutableAttributedString + Extension.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/3/6.
//

import UIKit

extension NSMutableAttributedString {
    
    func setFontForText(_ textToFind: String, with font: UIFont) {
        let range = mutableString.range(of: textToFind, options: .caseInsensitive)
        if range.location != NSNotFound {
            addAttribute(NSAttributedString.Key.font, value: font, range: range)
        }
    }
    
}
