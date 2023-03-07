//
//  String + Extensions.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/3/6.
//

import UIKit

extension String {
    
    func attributed(font: FontBook.FontType,
                    size: FontBook.FontSize,
                    color: UIColor,
                    lineSpacing: CGFloat = 0,
                    alignment: NSTextAlignment = .left) -> NSMutableAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        let _font = FontBook.font(font, fontSize: size)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.alignment = alignment

        attributeString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributeString.length))
        attributeString.addAttribute(NSAttributedString.Key.font, value: _font, range: NSMakeRange(0, attributeString.length))
        attributeString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: NSMakeRange(0, attributeString.length))

        return attributeString
    }

}


