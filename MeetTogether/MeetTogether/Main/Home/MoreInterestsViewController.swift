//
//  MoreInterestsViewController.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/2/27.
//

import UIKit

class MoreInterestsViewController: UIViewController {
    
    private lazy var dataSource = makeDataSource()
    
    private lazy var closeBtn: UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        btn.makeCloseStyle()
        btn.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        
        return btn
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewlayout)
        collectionView.backgroundColor = .clear
        collectionView.register(cellWithClass: InterestEventCollectionViewCell.self)
        collectionView.delegate = self
        return collectionView
    }()
    
    private var interestLayoutSection: NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(120))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(120))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 12
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)

        return section
    }
    
    private lazy var collectionViewlayout: UICollectionViewLayout = {
        let layout = UICollectionViewCompositionalLayout(section: interestLayoutSection)
        return layout
    }()
    
//    override func viewWillAppear(_ animated: Bool) {
//        configureNav()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        DispatchQueue.main.async {
            self.configureNav()
        }
        setUI()
        binding()
    }
    
    private func setupNav() {
        let closeItem = UIBarButtonItem(customView: closeBtn)
        self.navigationItem.leftBarButtonItem = closeItem
        self.title = "Your Interests"
    }
    
    private func configureNav() {
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.Neutral.dark.cgColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 0.25)
        self.navigationController?.navigationBar.layer.shadowRadius = 2
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.25
        self.navigationController?.navigationBar.layer.masksToBounds = false
    }
    
    @objc func closeAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setUI() {
        view.backgroundColor = .white
        view.addSubviews([collectionView])
        collectionView.snp.makeConstraints({
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(1)
            $0.leading.trailing.bottom.equalToSuperview()
        })
    }
    
    private func binding() {
        configureDataSource()
    }
    
}
extension MoreInterestsViewController {
    private func makeDataSource() -> UICollectionViewDiffableDataSource<Section, EventsViewData> {
        return UICollectionViewDiffableDataSource(collectionView: collectionView) {
            collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(withClass: InterestEventCollectionViewCell.self, for: indexPath)
            cell.configure(viewData: item)
            return cell
        }
    }

    private func configureDataSource() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, EventsViewData>()
        snapshot.appendSections([.main])
        let interestItems = [EventsViewData(type: .event, cornerRadius: 16, eventImage: UIImage(named: "Event"), date: "FEBRUARY 22, 2023, 1 – 3PM", title: "MEET THE F.B.I.", subtitle:  "Scott Sandersfield and Special Agent-Retired Jim Anderson will speak on all things Bureau and answer questions on February 22, 2023 at 1:00.", location: "Stafford Center, STF-104"), EventsViewData(type: .event, cornerRadius: 16, eventImage: UIImage(named: "Event_1"), date: "FEBRUARY 22, 2023, 1 – 3PM", title: "Bowling Night", subtitle:  "Prizes, snakes, and refreshments will be provided!", location: "Mann South Lobby")]
        
        snapshot.appendItems(interestItems)

        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: false)
        }
    }
}
extension MoreInterestsViewController {
    private enum Section {
        case main
    }
}
extension MoreInterestsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        print(item.type)
        let vc = CalendarDetailViewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
