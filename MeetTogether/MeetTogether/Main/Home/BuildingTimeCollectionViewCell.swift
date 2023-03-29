//
//  BuildingTimeCollectionViewCell.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/3/29.
//

import UIKit

struct BuildingTimeViewData: Hashable {
    let openDate: String
    let openTime: String
}

class BuildingTimeCollectionViewCell: UICollectionViewCell {
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.apply(font: FontBook.font(.bold, fontSize: .size(18)), textColor: UIColor.Blue.dark)
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.apply(font: FontBook.font(.regular, fontSize: .normal), textColor: .Neutral.dark, numberOfLines: 2, lineBreakMode: .byWordWrapping)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraint()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraint() {
        contentView.addSubviews([dateLabel, timeLabel])
        dateLabel.snp.makeConstraints({
            $0.top.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        })
        timeLabel.snp.makeConstraints({
            $0.top.equalTo(dateLabel.snp.bottom)
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.trailing.equalToSuperview().offset(-16)
        })
    }
    
    func configure(viewData: BuildingTimeViewData) {
        dateLabel.text = viewData.openDate
        timeLabel.text = viewData.openTime
    }
}
    
