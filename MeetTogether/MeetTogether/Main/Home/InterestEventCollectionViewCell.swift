//
//  IntersestEventCollectionViewCell.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/2/17.
//

import UIKit
import SDWebImage

enum InterestEventsType {
    case home
    case event
}

struct EventsViewData: Hashable {
    static func == (lhs: EventsViewData, rhs: EventsViewData) -> Bool {
        lhs.uuid == rhs.uuid
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }

    let uuid = UUID().uuidString
    let type: InterestEventsType
    let cornerRadius: Int
    let eventImage: String?
    let date: String
    let title: String
    let subtitle: String
    let location: String
    
    init(type: InterestEventsType, cornerRadius:Int = 0, eventImage: String? = nil, date: String,
         title: String, subtitle: String, location: String) {
        self.type = type
        self.cornerRadius = cornerRadius
        self.eventImage = eventImage
        self.date = date
        self.title = title
        self.subtitle = subtitle
        self.location = location
    }
}
class InterestEventCollectionViewCell: UICollectionViewCell {
    
    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.apply(font: FontBook.font(.bold, fontSize: .small), textColor: .Neutral.dark)
        return label
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.apply(font: FontBook.font(.sfproBold, fontSize: .size(18)), textColor: .Blue.dark, numberOfLines: 0)
        return label
    }()
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.apply(font: FontBook.font(.regular, fontSize: .size(16)), textColor: .black, numberOfLines: 0)
        return label
    }()

    private let locationLabel: UILabel = {
        let label = UILabel()
        label.apply(font: FontBook.font(.sfproRegular, fontSize: .small), textColor: .Neutral.secGrey)
        return label
    }()
    
    private let eventImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true

        return imageView
    }()
    
    private let interestButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = FontBook.font(.medium, fontSize: .normal)
        button.setImage(UIImage(named: "icon_heart"), for: .normal)
        button.addTarget(self, action: #selector(interestButtonDidTapped), for: .touchUpInside)
        return button
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
        contentView.addSubview(cardView)
        cardView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        cardView.addSubviews([eventImageView, dateLabel, titleLabel, subtitleLabel, locationLabel])
        eventImageView.snp.makeConstraints({
            $0.top.equalTo(dateLabel.snp.bottom).offset(-5)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(90)
            $0.width.equalTo(90)
        })
        dateLabel.snp.makeConstraints({
            $0.top.leading.equalToSuperview().offset(16)
            $0.trailing.equalTo(eventImageView.snp.leading).offset(-6)
        })
        titleLabel.snp.makeConstraints({
            $0.top.equalTo(dateLabel.snp.bottom).offset(6)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalTo(eventImageView.snp.leading).offset(-6)
        })
        subtitleLabel.snp.makeConstraints({
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalTo(eventImageView.snp.leading).offset(-16)
            $0.height.equalTo(65)
        })
        
        locationLabel.snp.makeConstraints({
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(6)
            $0.trailing.equalTo(eventImageView.snp.leading).offset(-6)
            $0.bottom.equalToSuperview().offset(-16)
        })
        
    }
    
    func configure(viewData: EventsViewData) {
        let type = viewData.type
        cardView.layer.cornerRadius = CGFloat(viewData.cornerRadius)
        eventImageView.sd_setImage(with: URL(string: viewData.eventImage ?? ""))
        dateLabel.text = viewData.date
        titleLabel.text = viewData.title
        subtitleLabel.text = viewData.subtitle
        locationLabel.text = viewData.location
        switch type {
        case .home:
            break
        case .event:
            cardView.addSubviews([interestButton])
            interestButton.snp.makeConstraints({
                $0.centerY.equalTo(locationLabel)
                $0.trailing.equalToSuperview().offset(-16)
                $0.width.height.equalTo(32)
            })
        }
    }

}
private extension InterestEventCollectionViewCell {
    
    @objc func interestButtonDidTapped() {
        print("Lilk")
    }
}


