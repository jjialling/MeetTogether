//
//  BuildingTimeViewController.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/3/29.
//

import UIKit
import Combine

class BuildingTimeViewController: UIViewController {
    
    private lazy var dataSource = makeDataSource()
    
    private let viewModel = BuildingTimeViewModel()
    
    var cancellables = Set<AnyCancellable>()
    
    private lazy var closeBtn: UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        btn.makeCloseStyle()
        btn.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        
        return btn
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewlayout)
        collectionView.backgroundColor = .clear
        collectionView.register(cellWithClass: BuildingTimeCollectionViewCell.self)
        collectionView.register(supplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withClass: HeaderMoreCollectionReusableView.self)
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()

    private var interestLayoutSection: NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(120))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(120))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
       
        section.boundarySupplementaryItems = [createHeader()]

        return section
    }
    
    private lazy var collectionViewlayout: UICollectionViewLayout = {
        let layout = UICollectionViewCompositionalLayout(section: interestLayoutSection)
        return layout
    }()
    
    deinit {
        debugPrint("deinit \(NSStringFromClass(Swift.type(of: self)))")
        cancellables.removeAll()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        DispatchQueue.main.async {
            self.configureNav()
        }
        setUI()
        viewModel.fetchBuildingTimeList()
        binding()
    }
    
    private func setupNav() {
        let closeItem = UIBarButtonItem(customView: closeBtn)
        self.navigationItem.leftBarButtonItem = closeItem
        self.title = "Building Time"
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
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.bottom.equalToSuperview()
        })
    }
    
    private func binding() {
        viewModel.$buildingTimeList
            .sink { [weak self] buildingTimeList in
                guard let self = self else { return }
                self.configureDataSource(buildingTimeList: buildingTimeList)
            }
            .store(in: &cancellables)
    }

}
extension BuildingTimeViewController {
    private func makeDataSource() -> UICollectionViewDiffableDataSource<String, BuildingTimeViewData> {
        return UICollectionViewDiffableDataSource(collectionView: collectionView) {
            collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(withClass: BuildingTimeCollectionViewCell.self, for: indexPath)
            cell.configure(viewData: item)
            return cell
        }
    }

    private func configureDataSource(buildingTimeList: [String:BuildingTimeList]) {
        var snapshot = NSDiffableDataSourceSnapshot<String, BuildingTimeViewData>()
        let buildingTimeList:[BuildingTimeList] = buildingTimeList.map { return $0.value }
        
        for list in buildingTimeList {
            snapshot.appendSections([list.name])
            
            let items = list.businessHours.map({
                BuildingTimeViewData(openDate: $0.date, openTime: $0.time)
            })
            snapshot.appendItems(items)
            
        }
  
        dataSource.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            self?.supplementary(collectionView: collectionView, kind: kind, indexPath: indexPath)
        }
        
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: false)
        }
    }
}
extension BuildingTimeViewController {
    private func createHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        header.pinToVisibleBounds = false
        return header
    }

    private func supplementary(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? {
        let section = dataSource.snapshot().sectionIdentifiers[indexPath.section]
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withClass: HeaderMoreCollectionReusableView.self, for: indexPath)
        
        header.configureUI(tag: indexPath.section,
                           backgroundColor: UIColor.Blue.dark,
                           textColor: UIColor.white,
                           title: section,
                           titleFont: FontBook.font(.bold, fontSize: .size(24)),
                           moreTitle: nil,
                           padding: 16)
       
        return header
    }
}
