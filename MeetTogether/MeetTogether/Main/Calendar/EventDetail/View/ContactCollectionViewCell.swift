//
//  ContactCollectionViewCell.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/3/4.
//

import UIKit

struct ContactViewData: Hashable {
    let title: String
    let value: String?
}

class ContactCollectionViewCell: UICollectionViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.apply(font: FontBook.font(.medium, fontSize: .small), textColor: UIColor.black, numberOfLines: 0)
        return label
    }()

    private let contentLabel: UILabel = {
        let label = UILabel()
        label.apply(font: FontBook.font(.sfproMedium, fontSize: .small), textColor: .Neutral.secGrey, textAlignment: .right, numberOfLines: 0)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraint()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraint() {
        contentView.backgroundColor = .white
        contentView.addSubviews([titleLabel, contentLabel])
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(42)
            make.width.equalTo(150) 
        }
        contentLabel.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.trailing.equalToSuperview().offset(-42)
            make.leading.equalTo(titleLabel.snp.trailing).offset(20)
        }
    }
    
    func configure(viewData: ContactViewData) {
        titleLabel.text = viewData.title
        contentLabel.text = viewData.value
    }
}
