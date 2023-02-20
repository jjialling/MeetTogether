//
//  BannerCollectionViewCell.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/2/17.
//

import UIKit

struct BannerViewData: Hashable {
    let id: Int
}

class BannerCollectionViewCell: UICollectionViewCell {

    private lazy var bannerScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentSize.height = 300
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.transform = CGAffineTransform(scaleX: 1, y: 1)
        pageControl.pageIndicatorTintColor = .Neutral.lightGrey
        pageControl.currentPageIndicatorTintColor = .Neutral.dark
        pageControl.addTarget(self, action: #selector(pageChanged), for: .valueChanged)
        return pageControl
    }()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraint()
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraint() {
        contentView.addSubviews([bannerScrollView, pageControl])
        bannerScrollView.snp.makeConstraints({
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(300)
        })
        pageControl.snp.makeConstraints({
            $0.bottom.equalToSuperview().offset(-16)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(260)
            $0.height.equalTo(28)
        })
        
    }
    
    @objc func pageChanged() {
        let offset = CGPoint(x: (bannerScrollView.frame.width) * CGFloat(pageControl.currentPage), y: 0)
        bannerScrollView.setContentOffset(offset, animated: true)
    }
    
    func configure(viewData: BannerViewData) {
        for i in 0..<3 {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.frame = CGRect(x: CGFloat(i)*Constant.ScreenWidth, y: 0, width:Constant.ScreenWidth, height: 300)
            imageView.image = UIImage(named: "News_\(i)")
            bannerScrollView.addSubview(imageView)
        }
        
        bannerScrollView.contentSize.width = CGFloat(3)*Constant.ScreenWidth
        pageControl.numberOfPages = 3
    }
    
}
extension BannerCollectionViewCell: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(round(scrollView.contentOffset.x/scrollView.frame.width))
        pageControl.currentPage = page
    }
}
