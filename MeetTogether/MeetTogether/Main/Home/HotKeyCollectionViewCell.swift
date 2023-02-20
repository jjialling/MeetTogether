//
//  HotKeyCollectionViewCell.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/2/17.
//

import UIKit

struct HotKeyViewData: Hashable {
    let id: Int
    let image: UIImage?
    let title: String
}

class HotKeyCollectionViewCell: UICollectionViewCell {

    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 24
        return view
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.apply(font: FontBook.font(.regular, fontSize: .size(12)), textColor: .Neutral.dark, textAlignment: .center)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraint()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        DispatchQueue.main.async {
            self.cardView.drawShadow()
        }
    }

    private func setupConstraint() {
        contentView.addSubview(cardView)
        cardView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })

        cardView.addSubviews([imageView, titleLabel])
        imageView.snp.makeConstraints({
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(13)
            $0.width.height.equalTo(28)
        })
        titleLabel.snp.makeConstraints({
            $0.top.equalTo(imageView.snp.bottom).offset(8)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-12)
        })
    }

    func configure(viewData: HotKeyViewData) {
        imageView.image = viewData.image
        titleLabel.text = viewData.title
    }
}


