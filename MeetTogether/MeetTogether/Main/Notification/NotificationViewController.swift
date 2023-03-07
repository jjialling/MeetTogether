//
//  NotificationViewController.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/3/5.
//

import UIKit

class NotificationViewController: UIViewController {
    
    private lazy var dataSource = makeDataSource()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.apply(font: FontBook.font(.bold, fontSize: .size(28)), textColor: .black)
        label.text = "Notifications"
        return label
    }()
    
    private let readAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("Mark all as read", for: .normal)
        button.setTitleColor(.Blue.dark, for: .normal)
        button.titleLabel?.font = FontBook.font(.medium, fontSize: .size(15))
//        button.addTarget(self, action: #selector(filterButtonDidTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewlayout)
        collectionView.backgroundColor = .clear
        collectionView.register(cellWithClass: NotificationCollectionViewCell.self)
        collectionView.delegate = self
        return collectionView
    }()
    
    private var interestLayoutSection: NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(120))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(120))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0)

        return section
    }
    
    private lazy var collectionViewlayout: UICollectionViewLayout = {
        let layout = UICollectionViewCompositionalLayout(section: interestLayoutSection)
        return layout
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        binding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func setUI() {
        view.backgroundColor = .Neutral.whiteGrey
        view.addSubviews([titleLabel, readAllButton, collectionView ])
        titleLabel.snp.makeConstraints({
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(87)
            $0.height.equalTo(30)
        })
        readAllButton.snp.makeConstraints({
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(20)
        })
        collectionView.snp.makeConstraints({
            $0.top.equalTo(titleLabel.snp.bottom).offset(24)
            $0.leading.trailing.bottom.equalToSuperview()
        })
    }
    
    private func binding() {
        configureDataSource()
    }
    
}
extension NotificationViewController {
    private func makeDataSource() -> UICollectionViewDiffableDataSource<Section, NotificationViewData> {
        return UICollectionViewDiffableDataSource(collectionView: collectionView) {
            collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(withClass: NotificationCollectionViewCell.self, for: indexPath)
            cell.configure(viewData: item)
            return cell
        }
    }

    private func configureDataSource() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, NotificationViewData>()
        
        snapshot.appendSections([.main])
        let eventItems = [NotificationViewData(image: "icon_user_circle", name: "Jaenny Wilson", content: "joined your event", post: "Brass Ensembles Concert.", read: false), NotificationViewData(image: "icon_user_circle", name: "Robert Fox", content: "joined your event", post: "Brass Ensembles Concert.", read: true)]
        snapshot.appendItems(eventItems)

        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: false)
        }
    }
}
extension NotificationViewController {
    private enum Section {
        case main
    }
}
extension NotificationViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        print(item.name)
        let vc = AttendPeopleViewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
