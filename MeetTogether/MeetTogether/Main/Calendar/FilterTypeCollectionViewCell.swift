//
//  FilterTypeCollectionViewCell.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/3/5.
//

import UIKit

enum FilterState {
    case normal
    case selected
}

class FilterViewData: Hashable {

    static func == (lhs: FilterViewData, rhs: FilterViewData) -> Bool {
        lhs.uuid == rhs.uuid
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }

    let uuid = UUID().uuidString
    var type: FixFilterLabelType
    var state: FilterState

    init(type: FixFilterLabelType, state: FilterState) {
        self.type = type
        self.state = state
    }

}

class FilterTypeCollectionViewCell: UICollectionViewCell {

    private lazy var filterLabel: UILabel = {
        let label = UILabel()
        label.apply(font: FontBook.font(.sfproMedium, fontSize: .small), textColor: .Neutral.dark, textAlignment: .center)
        label.backgroundColor = .white
        label.layer.borderColor = UIColor.Neutral.lightGrey.cgColor
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
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
        contentView.backgroundColor = .white
        contentView.addSubviews([filterLabel])
        filterLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-8)
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(12)
            make.height.equalTo(32)
        }
    }

    func configure(viewData: FilterViewData) {
        filterLabel.text = viewData.type.title
        switch viewData.state {
        case .normal:
            filterLabel.backgroundColor =  UIColor.white
            filterLabel.textColor =  UIColor.Green.secGreen
        case .selected:
            filterLabel.backgroundColor =  UIColor.Green.secGreen
            filterLabel.textColor =  UIColor.white
        }
    }

}

