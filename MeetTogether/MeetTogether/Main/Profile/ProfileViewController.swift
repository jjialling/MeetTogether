//
//  ProfileViewController.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/2/9.
//

import UIKit

class ProfileViewController: UIViewController {
    override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .darkGray
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            navigationController?.setNavigationBarHidden(true, animated: false)
        }

        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            navigationController?.setNavigationBarHidden(false, animated: false)
        }
    
    
}
