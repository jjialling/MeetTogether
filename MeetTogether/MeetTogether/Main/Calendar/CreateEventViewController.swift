//
//  CreateEventViewController.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/3/6.
//

import UIKit

class CreateEventViewController: UIViewController {
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        configNavigationBar()
//        binding()
    }
    
    private func setUI() {
        view.backgroundColor = .white
    }
    
    private func configNavigationBar() {
        setLargeTitleStyle(title: "Create a new event", backgroundColor: .Blue.dark)
        setNavCloseButton()
    }
    
}
