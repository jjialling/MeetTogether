//
//  CalendarViewController.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/2/9.
//

import UIKit

class CalendarViewController: UIViewController {
    
    private lazy var dataSource = makeDataSource()
    
    private lazy var navigationView: UIView = {
        let nav = UIView()
        nav.backgroundColor = .Green.lightGreen
        return nav
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.setImage(UIImage(named: "icon_search_bar"), for: .search, state: .normal)
        searchBar.searchTextField.backgroundColor = .white
        searchBar.backgroundImage = UIImage()
        searchBar.placeholder = "Exlore events"
        searchBar.delegate = self
        return searchBar
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.apply(font: FontBook.font(.bold, fontSize: .size(28)), textColor: .white)
        label.text = "Official"
        return label
    }()
    
    private let filterButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icon_nav_condition"), for: .normal)
        button.addTarget(self, action: #selector(filterButtonDidTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewlayout)
        collectionView.backgroundColor = .clear
        collectionView.register(cellWithClass: IntersestEventCollectionViewCell.self)
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
        view.addSubviews([navigationView, collectionView])
        navigationView.addSubviews([titleLabel, filterButton, searchBar])
        navigationView.snp.makeConstraints({
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalTo(177)
        })
        titleLabel.snp.makeConstraints({
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(87)
            $0.height.equalTo(30)
        })
        filterButton.snp.makeConstraints({
            $0.trailing.equalToSuperview().offset(-6)
            $0.bottom.equalTo(titleLabel.snp.top)
            $0.width.height.equalTo(30)
        })
        searchBar.snp.makeConstraints({
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.top.equalTo(titleLabel.snp.bottom).offset(7)
            $0.height.equalTo(40)
        })
        collectionView.snp.makeConstraints({
            $0.top.equalTo(navigationView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        })
    }
    
    private func binding() {
        configureDataSource()
    }
    
    @objc func filterButtonDidTapped() {
        sortEventsAction{}
    }
    
    func sortEventsAction(complete: @escaping () -> Void) {
        let alertVC = UIAlertController(title: nil, message: "Filters", preferredStyle: .actionSheet)
        
        let expiredDateSortAction = UIAlertAction(title: "Dates", style: .default) { (_) in
            print("Dates")
        }
        
        let eventNameAToZSortAction = UIAlertAction(title: "A-Z", style: .default) { (_) in
            print("A-Z")
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertVC.addAction(expiredDateSortAction)
        alertVC.addAction(eventNameAToZSortAction)
        alertVC.addAction(cancelAction)
        DispatchQueue.main.async {
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
}
extension CalendarViewController {
    private func makeDataSource() -> UICollectionViewDiffableDataSource<Section, EventsViewData> {
        return UICollectionViewDiffableDataSource(collectionView: collectionView) {
            collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(withClass: IntersestEventCollectionViewCell.self, for: indexPath)
            cell.configure(viewData: item)
            return cell
        }
    }

    private func configureDataSource() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, EventsViewData>()
        snapshot.appendSections([.main])
        let eventItems = [EventsViewData(type: .event),EventsViewData(type: .event),EventsViewData(type: .event),EventsViewData(type: .event)]
        snapshot.appendItems(eventItems)

        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: false)
        }
    }
}
extension CalendarViewController {
    private enum Section {
        case main
    }
}
extension CalendarViewController: UISearchBarDelegate {
    
}
extension CalendarViewController:  UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        print(item.type)
    }
}