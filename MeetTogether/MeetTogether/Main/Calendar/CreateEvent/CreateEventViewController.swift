//
//  CreateEventViewController.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/3/6.
//

import UIKit

class CreateEventViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewlayout)
        collectionView.backgroundColor = .clear
        collectionView.register(cellWithClass: BannerCollectionViewCell.self)
        collectionView.register(cellWithClass: NewEventCollectionViewCell.self)
//        collectionView.delegate = self
        return collectionView
    }()
    
    private var cardLayoutSection: NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension:
        .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets.bottom = 15
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension:
        .fractionalWidth(0.7))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 16, leading: 16, bottom: 0, trailing: 2)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging

        return section
    }
    
    private var interestLayoutSection: NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(120))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(120))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)

        return section
    }
    
    private lazy var collectionViewlayout: UICollectionViewLayout = {
        UICollectionViewCompositionalLayout { [unowned self] index, enviroment in
            let section = Section(rawValue: index) ?? .photo
            switch section {
            case .photo:
                return cardLayoutSection
            case .info:
                return interestLayoutSection
            default:
                return cardLayoutSection
            }
        }
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        configNavigationBar()
//        binding()
    }
    
    private func setUI() {
        view.backgroundColor = .white
    }
    
    private func configNavigationBar() {
        setLargeTitleStyle(title: "Create a new event", backgroundColor: .Blue.dark)
        setNavCloseButton()
    }
    
}
extension CreateEventViewController {
    private enum Section: Int, CaseIterable {
        case photo = 0
        case info
    }
}
