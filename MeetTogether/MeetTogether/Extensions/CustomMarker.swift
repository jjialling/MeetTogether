//
//  CustomMarker.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/3/8.
//

import UIKit
import GoogleMaps

class CustomMarker: GMSMarker {

    var label: UILabel!
    var imageViewForPinMarker : UIImageView!

    init(labelText: String) {
        super.init()

        let iconView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 90, height: 90)))
        iconView.backgroundColor = .clear

        label = UILabel(frame:CGRect(origin: CGPoint(x: 0,y :5), size: CGSize(width: iconView.bounds.width, height: 80)))
        label.text = labelText
        label.font = FontBook.font(.bold, fontSize: .size(13))
        label.textColor = .Green.secGreen
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.textAlignment = .center
        
        imageViewForPinMarker  = UIImageView(frame:CGRect(origin: CGPoint(x: 0,y :34), size: CGSize(width: 55, height: 66)))
        imageViewForPinMarker.image = UIImage(named:"icon_location_pin_normal")
        
        iconView.addSubviews([imageViewForPinMarker, label])

        self.iconView = iconView
    }
}
