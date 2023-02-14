//
//  HomeViewController.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/2/9.
//

import UIKit

class HomeViewController: UIViewController {
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func setUI() {
        view.backgroundColor = UIColor(hex: "#191919")
        let navigationBar = setupNavigationBar()
        view.addSubviews([navigationBar])
        navigationBar.snp.makeConstraints({
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalTo(108)
        })
    }
}
private extension HomeViewController {
    func setupNavigationBar() -> UIView {
        let containerView = UIView()
        containerView.backgroundColor = .white
        let iconImage = UIImageView()
        iconImage.image = UIImage(named: "thsrLogo")
        iconImage.contentMode = .scaleAspectFill
        
        containerView.addSubviews([iconImage])
        iconImage.snp.makeConstraints({
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(56)
            $0.bottom.equalToSuperview().offset(-12)
            $0.width.equalTo(138)
        })
        return containerView
    }
    
}

