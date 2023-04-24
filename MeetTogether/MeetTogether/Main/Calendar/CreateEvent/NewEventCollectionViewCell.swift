//
//  NewEventCollectionViewCell.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/3/26.
//

import UIKit

class NewEventCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraint()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraint() {
        contentView.backgroundColor = .white
//        contentView.addSubviews([titleLabel, contentLabel])
      
    }
    
//    func configure(viewData: ) {
//
//    }
}
