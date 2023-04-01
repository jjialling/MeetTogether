//
//  UserImageCollectionViewCell.swift
//  MeetTogether
//
//  Created by Elias Rodriguez on 4/1/23.
//

import UIKit

struct UserImageViewData: Hashable {
    let imageName: String
    let name: String
}

class UserImageCollectionViewCell: UICollectionViewCell {
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true

        return imageView
    }()
    
    private let profileNameLabel: UILabel = {
        let label = UILabel()
        label.apply(font: FontBook.font(.sfproBold, fontSize: .size(18)), textColor: .black, textAlignment: .center, numberOfLines: 0)
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
        contentView.addSubviews([profileImageView, profileNameLabel])
        profileImageView.snp.makeConstraints({
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(120)
            $0.top.equalToSuperview().offset(88)
            
        })
        profileNameLabel.snp.makeConstraints ({
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.top.equalTo(profileImageView.snp.bottom).offset(12)
            $0.bottom.equalToSuperview()
            
        })
        
    }
    
    func configure(viewData: UserImageViewData) {
        profileImageView.image = UIImage(named: "\(viewData.imageName)")
        profileNameLabel.text = viewData.name
    }
    
}

