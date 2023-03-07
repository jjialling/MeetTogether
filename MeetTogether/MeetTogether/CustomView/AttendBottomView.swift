//
//  AttendBottomView.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/3/4.
//

import UIKit

class AttendBottomView: UIView {
    
    private lazy var attendButton: UIButton = {
        let button = UIButton()
        button.setTitle("Join", for: .normal)
        button.titleLabel?.font = FontBook.font( .bold, fontSize: .normal)
        button.backgroundColor = .Green.secGreen
        button.addTarget(self, action: #selector(attendButtonDidTapped(_:)), for: .touchUpInside)
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        setupConstraint()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        DispatchQueue.main.async {
            self.drawShadow()
        }
    }
    
    private func setupConstraint() {
        self.backgroundColor = .white
        self.addSubviews([attendButton])
        attendButton.snp.makeConstraints({
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(42)
            $0.trailing.equalToSuperview().offset(-42)
            $0.height.equalTo(48)
        })
        
    }
    
}
extension AttendBottomView {
    @objc func attendButtonDidTapped(_ sender: UIButton) {
       
    }
}
