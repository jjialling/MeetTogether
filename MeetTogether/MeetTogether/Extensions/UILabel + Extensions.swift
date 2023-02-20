//
//  UILabel + Extensions.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/2/17.
//

import UIKit

extension UILabel {
    func setLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0, alignment: NSTextAlignment = .left) {

        guard let labelText = text else { return }

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        paragraphStyle.alignment = alignment

        let attributedString: NSMutableAttributedString
        if let labelattributedText = attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }

        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))

        attributedText = attributedString
    }

    func strikeThrough() {
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: text ?? "")

        attributeString.addAttribute(.strikethroughStyle,
                                     value: NSUnderlineStyle.single.rawValue,
                                     range: NSMakeRange(0, attributeString.length))
        attributedText = attributeString
    }

    func setScalableFont(_ font: UIFont) {
        let screenWidth = UIScreen.main.bounds.width
        let fontSize: CGFloat
        if screenWidth <= 375 {
            fontSize = font.pointSize
        } else if screenWidth == 414 {
            fontSize = font.pointSize + 2
        } else {
            fontSize = font.pointSize + 4
        }

        self.font = font.withSize(fontSize)
    }

    // MARK: Set Scale font by ScreenWidth
    func setScale(_ font: UIFont) {
        let screenWidth = UIScreen.main.bounds.width
        let fontSize: CGFloat
        if screenWidth < 375 {
            fontSize = font.pointSize * 1
        } else if screenWidth < 414 {
            fontSize = font.pointSize * 1.17
        } else {
            fontSize = font.pointSize * 1.29
        }

        self.font = font.withSize(fontSize)
    }

    var numberOfVisibleLines: Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(MAXFLOAT))
        let textHeight = sizeThatFits(maxSize).height
        let lineHeight = font.lineHeight
        return Int(ceil(textHeight / lineHeight))
    }

    func apply(font: UIFont,
               textColor: UIColor,
               textAlignment: NSTextAlignment = .left,
               numberOfLines: Int = 1,
               lineBreakMode: NSLineBreakMode = .byTruncatingTail) {
        self.font = font
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
        self.lineBreakMode = lineBreakMode
    }
}

