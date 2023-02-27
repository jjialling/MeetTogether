//
//  UIButton + Extensions.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/2/27.
//

import UIKit

extension UIButton {
    
    func makeCloseStyle(bgColor: UIColor = .Neutral.whiteStroke) {
        self.setImage(UIImage(named: "icon_close"), for: .normal)
        self.backgroundColor = bgColor
        self.layer.cornerRadius = 16
        self.clipsToBounds = true
    }
}
