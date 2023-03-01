//
//  Utility.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/2/27.
//

import Foundation
import UIKit

struct Utility {
    static func openURLWithSafari(_ string: String) {
        guard let url = URL(string: string), UIApplication.shared.canOpenURL(url) else {
            return
        }
        debugPrint("openURLWithSafari: \(string)")
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
