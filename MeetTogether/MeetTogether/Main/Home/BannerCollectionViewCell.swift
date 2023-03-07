//
//  BannerCollectionViewCell.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/2/17.
//

import UIKit

struct BannerViewData: Hashable {
    let image: String
}

class BannerCollectionViewCell: UICollectionViewCell {
    
    private let bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true

        return imageView
    }()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraint()
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraint() {
        contentView.addSubviews([bannerImageView])
        bannerImageView.snp.makeConstraints({
            $0.top.leading.trailing.bottom.equalToSuperview()
//            $0.height.equalTo(300)
        })
        
    }

    func configure(viewData: BannerViewData) {
        bannerImageView.image = UIImage(named: "\(viewData.image)")
    }
}

