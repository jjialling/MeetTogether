//
//  HomeViewController.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/2/9.
//

import UIKit

class HomeViewController: UIViewController {
    
    private lazy var dataSource = makeDataSource()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewlayout)
        collectionView.backgroundColor = .clear
        collectionView.register(cellWithClass: BannerCollectionViewCell.self)
        collectionView.register(cellWithClass: InterestEventCollectionViewCell.self)
        collectionView.register(cellWithClass: HotKeyCollectionViewCell.self)
        collectionView.register(supplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withClass: HeaderMoreCollectionReusableView.self)
//        collectionView.delegate = self
        return collectionView
    }()

    private var cardLayoutSection: NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(300))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)

        return section
    }

    private var interestLayoutSection: NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(120))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(120))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 12
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        section.boundarySupplementaryItems = [createHeader()]

        return section
    }

    private var hotKeyLayoutSection: NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(84))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        group.interItemSpacing = .fixed(12)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 24, trailing: 16)
        section.boundarySupplementaryItems = [createHeader()]

        return section
    }

    private lazy var collectionViewlayout: UICollectionViewLayout = {
        UICollectionViewCompositionalLayout { [unowned self] index, enviroment in
            let section = Section(rawValue: index) ?? .hotKey
            switch section {
            case .hotKey:
                return hotKeyLayoutSection
            case .interest:
                return interestLayoutSection
            default:
                return cardLayoutSection
            }
        }
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

//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: false)
//    }
//    
    private func setUI() {
        view.backgroundColor = .Neutral.whiteStroke
        let navigationBar = setupNavigationBar()
        view.addSubviews([navigationBar, collectionView])
        navigationBar.snp.makeConstraints({
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalTo(108)
        })
        collectionView.snp.makeConstraints({
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        })
    }
  
    private func binding() {
        configureDataSource()
    }
}
private extension HomeViewController {
    func setupNavigationBar() -> UIView {
        let containerView = UIView()
        containerView.backgroundColor = .white
        let iconImage = UIImageView()
        iconImage.image = UIImage(named: "thsrLogo")
        iconImage.contentMode = .scaleAspectFill
        
        containerView.addSubviews([iconImage])
        iconImage.snp.makeConstraints({
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(56)
            $0.bottom.equalToSuperview().offset(-12)
            $0.width.equalTo(138)
        })
       
        return containerView
    }
    
}

extension HomeViewController {
    private func makeDataSource() -> UICollectionViewDiffableDataSource<Section, Item> {
        return UICollectionViewDiffableDataSource(collectionView: collectionView) {
            collectionView, indexPath, item in
            switch item {
            case .banner(let model):
                let cell = collectionView.dequeueReusableCell(withClass: BannerCollectionViewCell.self, for: indexPath)
                cell.configure(viewData: model)
                return cell
            case .interest(let model):
                let cell = collectionView.dequeueReusableCell(withClass: InterestEventCollectionViewCell.self, for: indexPath)
                cell.configure(viewData: model)
                return cell
            case .hotKey(let model):
                let cell = collectionView.dequeueReusableCell(withClass: HotKeyCollectionViewCell.self, for: indexPath)
                cell.configure(viewData: model)
                return cell
            }
        }
    }

    private func configureDataSource() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(Section.allCases)

        let bannerItems = [Item.banner(BannerViewData(id: 1))] /// Need to change
        snapshot.appendItems(bannerItems, toSection: .banner)
        
        let interestItems = [Item.interest(EventsViewData(type: .home, cornerRadius: 16, eventImage: UIImage(named: "Event"), date: "FEBRUARY 22, 2023, 1 – 3PM", title: "MEET THE F.B.I.", subtitle:  "Scott Sandersfield and Special Agent-Retired Jim Anderson will speak on all things Bureau and answer questions on February 22, 2023 at 1:00.", location: "Stafford Center, STF-104")), Item.interest(EventsViewData(type: .home, cornerRadius: 16, eventImage: UIImage(named: "Event_1"), date: "FEBRUARY 22, 2023, 1 – 3PM", title: "Bowling Night", subtitle:  "Prizes, snakes, and refreshments will be provided!", location: "Mann South Lobby"))]
        
        snapshot.appendItems(interestItems, toSection: .interest)

        let hotKeyItems = HotKeyType.allCases.map({ Item.hotKey(HotKeyViewData(id: $0.rawValue, image: $0.image, title: $0.title)) })
        snapshot.appendItems(hotKeyItems, toSection: .hotKey)

        dataSource.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            self?.supplementary(collectionView: collectionView, kind: kind, indexPath: indexPath)
        }
        
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: false)
        }
    }
}

extension HomeViewController {
    private func createHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(80))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        header.pinToVisibleBounds = false
        return header
    }

    private func supplementary(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? {
        let section = dataSource.snapshot().sectionIdentifiers[indexPath.section]

        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withClass: HeaderMoreCollectionReusableView.self, for: indexPath)
        
        header.configureUI(tag: indexPath.section,
                           title: section.headerTitle,
                           moreTitle: section.moreTitle)
        header.delegate = self
        return header
    }
}

extension HomeViewController: HeaderMoreViewDelegate {
    func headerMoreButtonDidTapped(tag: Int) {
        let vc = MoreInterestsViewController()
        self.presentFullScreen(UINavigationController(rootViewController: vc))
    }
    
}

extension HomeViewController {
    private enum Section: Int, CaseIterable {
        case banner = 0
        case interest
        case hotKey

        var headerTitle: String? {
            switch self {
            case .interest:
                return "Your Interests"
            case .hotKey:
                return "HotKey"
            default:
                return nil
            }
            
        }

        var moreTitle: String? {
            switch self {
            case .interest:
                return "See more"
            default:
                return nil
            }
        }
    }

    private enum Item: Hashable {
        case banner(BannerViewData)
        case interest(EventsViewData)
        case hotKey(HotKeyViewData)
    }
}
