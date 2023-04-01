//
//  ProfileViewController.swift
//  MeetTogether
//
//  Created by Elias Rodriguez on 2023/3/5.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var dataSource = makeDataSource()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewlayout)
        collectionView.backgroundColor = .clear
        collectionView.register(cellWithClass: UserImageCollectionViewCell.self)
        
        return collectionView
    }()
    
    private var profileLayoutSection: NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(300))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)

        return section
    }
    
    private lazy var collectionViewlayout: UICollectionViewLayout = {
        let layout = UICollectionViewCompositionalLayout(section:  profileLayoutSection)
        return layout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        configureDataSource()
    }
    
    func setUI() {
        view.addSubviews([collectionView])
        collectionView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
    }
    
}
extension ProfileViewController {
    private func makeDataSource() -> UICollectionViewDiffableDataSource<Section, UserImageViewData> {
        return UICollectionViewDiffableDataSource(collectionView: collectionView) {
            collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(withClass: UserImageCollectionViewCell.self, for: indexPath)
            cell.configure(viewData: item)
            return cell
        }
    }
    
    private func configureDataSource() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, UserImageViewData>()
        snapshot.appendSections([.profile])
        let profileItems = [UserImageViewData(imageName: "profilePic", name: "AAAAAAA") ]
        snapshot.appendItems(profileItems)
        
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: false)
        }
    }
}
extension ProfileViewController {
    private enum Section {
        case profile
        
    }
    
}
