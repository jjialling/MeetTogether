//
//  NotificationCollectionViewCell.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/3/6.
//

import UIKit
import RxSwift

struct NotificationViewData: Hashable {
    let image: String
    let name: String
    let content: String
    let post: String
}

class NotificationCollectionViewCell: UICollectionViewCell {
    
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.apply(font: FontBook.font(.regular, fontSize: .normal), textColor: .Neutral.dark, numberOfLines: 0, lineBreakMode: .byWordWrapping)
        return label
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .Neutral.whiteStroke
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraint()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraint() {
        contentView.addSubviews([userImageView, contentLabel, lineView])
    
        contentLabel.snp.makeConstraints({
            $0.top.equalToSuperview().offset(18)
            $0.leading.equalToSuperview().offset(78)
            $0.trailing.equalToSuperview().offset(-18)
        })
        userImageView.snp.makeConstraints({
            $0.centerY.equalTo(contentLabel)
            $0.leading.equalToSuperview().offset(18)
            $0.width.height.equalTo(40)
           
        })
        lineView.snp.makeConstraints({
            $0.top.equalTo(contentLabel.snp.bottom).offset(18)
            $0.trailing.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
           
        })
    }
    
    func configure(viewData: NotificationViewData) {
        let content = "\(viewData.content )"
        let post = "\(viewData.post)"
        let attributedString = "\(viewData.name) \(content) \(post)".attributed(font: .bold, size: .normal, color: .Neutral.dark)
        attributedString.setFontForText(content, with: FontBook.font(.regular, fontSize: .normal))
        attributedString.setFontForText(post, with: FontBook.font(.bold, fontSize: .normal))
        contentLabel.attributedText = attributedString
        userImageView.image = UIImage(named: "\(viewData.image)")
    }
    
}
