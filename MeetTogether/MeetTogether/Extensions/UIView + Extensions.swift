//
//  UIView + Extensions.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/2/13.
//

import SnapKit
import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        for view in views {
            addSubview(view)
        }
    }

    var safeArea: ConstraintBasicAttributesDSL {
        #if swift(>=3.2)
            if #available(iOS 11.0, *) {
                return self.safeAreaLayoutGuide.snp
            } else {
                return snp
            }
        #else
            return snp
        #endif
    }

    func addTapGesture(tapNumber number: Int, target: AnyObject, action: Selector) {
        let tap = UITapGestureRecognizer(target: target, action: action)
        tap.numberOfTapsRequired = number
        tap.cancelsTouchesInView = false
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }

    func drawShadow(color: UIColor = UIColor.black.withAlphaComponent(0.1), opacity: Float = 0.8, offset: CGSize = .zero, radius: CGFloat = 5) {
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
    }

    func removeShadow() {
        layer.shadowColor = UIColor.clear.cgColor
        layer.shadowOpacity = 0.0
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 0.0
    }
}

