//
//  AttendPeopleViewController.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/3/6.
//

import UIKit

class AttendPeopleViewController: UIViewController {
    
    private lazy var dataSource = makeDataSource()
    
    private lazy var backBtn: UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        btn.makeBackStyle()
        btn.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        
        return btn
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewlayout)
        collectionView.backgroundColor = .clear
        collectionView.register(cellWithClass: NotificationCollectionViewCell.self)
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
        setupNav()
        DispatchQueue.main.async {
            self.configureNav()
        }
        binding()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    private func setupNav() {
        let backItem = UIBarButtonItem(customView: backBtn)
        self.navigationItem.leftBarButtonItem = backItem
        self.title = "Attendees(4)"
    }
    
    private func configureNav() {
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.Neutral.dark.cgColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 0.25)
        self.navigationController?.navigationBar.layer.shadowRadius = 2
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.25
        self.navigationController?.navigationBar.layer.masksToBounds = false
    }
    
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setUI() {
        view.backgroundColor = .white
        view.addSubviews([collectionView])
        collectionView.snp.makeConstraints({
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.bottom.equalToSuperview()
        })
    }
    
    private  func binding() {
        configureDataSource()
    }
}
extension AttendPeopleViewController {
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
        let eventItems = [NotificationViewData(image: "icon_user_circle", name: "Lily Wilson"), NotificationViewData(image: "icon_user_circle", name: "Robert Fox"), NotificationViewData(image: "icon_user_circle", name: "Yung-Han Chang"), NotificationViewData(image: "icon_user_circle", name: "Jeffrey Cole Evans")]
        snapshot.appendItems(eventItems)
        
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: false)
        }
    }
}
extension AttendPeopleViewController {
    private enum Section {
        case main
    }
}
extension AttendPeopleViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
