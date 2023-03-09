//
//  profileImageCell.swift
//  MeetTogether
//
//  Created by Elias Rodriguez on 3/7/23.
//

import UIKit

class  profileImageCell: UICollectionViewCell {
    
    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.apply(font: FontBook.font(.bold, fontSize: .small), textColor: .Neutral.dark)
        return label
    }()
    
    private let profileImage: UIImage = {
        let image = UIImage()
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraint()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        DispatchQueue.main.async {
            self.cardView.drawShadow()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraint() {
        contentView.addSubviews([])
    
    }
    
}
