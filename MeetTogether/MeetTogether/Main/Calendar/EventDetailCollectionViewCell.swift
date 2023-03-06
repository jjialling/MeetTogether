//
//  EventDetailCollectionViewCell.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/3/4.
//

import UIKit

struct EventDetailViewData: Hashable {
    let title: String
    let date: String
    let content: String
}

class EventDetailCollectionViewCell: UICollectionViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.apply(font: FontBook.font(.sfproBold, fontSize: .size(25)), textColor: .Neutral.black, numberOfLines: 0)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.apply(font: FontBook.font(.sfproMedium, fontSize: .size(18)), textColor: .Neutral.grey, numberOfLines: 0)
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.apply(font: FontBook.font(.sfproBold, fontSize: .normal), textColor: .Neutral.dark, numberOfLines: 0, lineBreakMode: .byWordWrapping)
        return label
    }()
    
    private let interestButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = FontBook.font(.medium, fontSize: .normal)
        button.setImage(UIImage(named: "icon_heart"), for: .normal)
//        button.addTarget(self, action: #selector(interestButtonDidTapped), for: .touchUpInside)
        return button
    }()
    
    private let checkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "icon_check")
        return imageView
    }()
    
    private let counterLabel: UILabel = {
        let label = UILabel()
        label.apply(font: FontBook.font(.sfproRegular, fontSize: .normal), textColor: .Neutral.dark)
        label.text = "17 going"
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
        contentView.addSubviews([titleLabel, dateLabel, contentLabel,
                                 interestButton, checkImageView, counterLabel])
        titleLabel.snp.makeConstraints({
            $0.top.equalToSuperview().offset(72)
            $0.leading.equalToSuperview().offset(42)
            $0.trailing.equalToSuperview().offset(-84)
        })
        dateLabel.snp.makeConstraints({
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(42)
            $0.trailing.equalToSuperview().offset(-84)
            $0.height.equalTo(20)
        })
        contentLabel.snp.makeConstraints({
            $0.top.equalTo(dateLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(42)
            $0.trailing.equalToSuperview().offset(-42)
            $0.bottom.equalToSuperview().offset(16)
        })
        interestButton.snp.makeConstraints({
            $0.top.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
            $0.width.height.equalTo(32)
        })
        counterLabel.snp.makeConstraints({
            $0.bottom.equalTo(interestButton.snp.bottom)
            $0.trailing.equalTo(interestButton.snp.leading).offset(-8)
            $0.height.equalTo(22)
        })
        checkImageView.snp.makeConstraints({
            $0.centerY.equalTo(interestButton)
            $0.trailing.equalTo(counterLabel.snp.leading).offset(-8)
            $0.width.height.equalTo(24)
        })
        
    }
    
    func configure(viewData: EventDetailViewData) {
        titleLabel.text = viewData.title
        dateLabel.text = viewData.date
        contentLabel.text = viewData.content
    }
    
}
