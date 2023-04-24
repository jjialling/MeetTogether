//
//  HeaderMoreCollectionReusableView.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/2/17.
//

import UIKit

protocol HeaderMoreViewDelegate: AnyObject {
    func headerMoreButtonDidTapped(tag: Int)
}

class HeaderMoreCollectionReusableView: UICollectionReusableView {

    weak var delegate: HeaderMoreViewDelegate?

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.apply(font: FontBook.font(.bold, fontSize: .size(18)), textColor: .black)
        return label
    }()

    private lazy var moreButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = FontBook.font(.sfproMedium, fontSize: .small)
        button.setTitleColor(.Green.whiteGreen, for: .normal)
        button.addTarget(self, action: #selector(moreButtonDidTapped(_:)), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews([titleLabel, moreButton])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraint(padding: CGFloat) {
        titleLabel.snp.remakeConstraints({
            $0.left.equalToSuperview().offset(padding)
            $0.top.bottom.equalToSuperview()
        })
        moreButton.snp.remakeConstraints({
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-padding)
        })
    }

    func configureUI(tag: Int,
                     backgroundColor: UIColor = .clear,
                     textColor: UIColor = .black,
                     title: String?,
                     titleFont: UIFont = FontBook.font(.bold, fontSize: .size(18)),
                     moreTitle: String?,
                     padding: CGFloat = 0) {
        self.backgroundColor = backgroundColor
        titleLabel.textColor = textColor
        titleLabel.text = title
        titleLabel.font = titleFont
        moreButton.tag = tag
        moreButton.setTitle(moreTitle ?? "", for: .normal)
        moreButton.isHidden = moreTitle == nil ? true : false
        setupConstraint(padding: padding)
    }
}

extension HeaderMoreCollectionReusableView {
    @objc func moreButtonDidTapped(_ sender: UIButton) {
        delegate?.headerMoreButtonDidTapped(tag: sender.tag)
    }
}

