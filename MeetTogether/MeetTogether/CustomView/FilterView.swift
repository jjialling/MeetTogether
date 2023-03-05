//
//  FilterView.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/3/5.
//

import UIKit

protocol FilterLabelViewDelegate: AnyObject {
    func filterLabelViewDidSelected(type: FixFilterLabelType)
}

class FixFilterView: UIView {

    weak var delegate: FilterLabelViewDelegate?

    private lazy var dataSource = makeDataSource()
    private var lastIndexPath = IndexPath(item: 0, section: 0)

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewlayout)
        collectionView.backgroundColor = .white
        collectionView.register(cellWithClass: FilterTypeCollectionViewCell.self)

        collectionView.delegate = self
        return collectionView
    }()

    private var filterLayoutSection: NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1 / 5),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .estimated(66))

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 17, bottom: 0, trailing: 9)
        section.orthogonalScrollingBehavior = .continuous

        return section
    }

    private lazy var collectionViewlayout: UICollectionViewLayout = {
        let layout = UICollectionViewCompositionalLayout(section: filterLayoutSection)
        return layout
    }()


    init() {
        super.init(frame: .zero)
        setupConstraint()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraint() {
        backgroundColor = .white
        addSubview(collectionView)
        collectionView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
    }

}
extension FixFilterView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        delegate?.filterLabelViewDidSelected(type: item.type)
        reloadFilterLabelDataSource(indexPath: lastIndexPath, state: .normal)
        reloadFilterLabelDataSource(indexPath: indexPath, state: .selected)
        lastIndexPath = indexPath
    }
}
extension FixFilterView {
    private func makeDataSource() -> UICollectionViewDiffableDataSource<Section, FilterViewData> {
        return UICollectionViewDiffableDataSource(collectionView: collectionView) {
            collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(withClass: FilterTypeCollectionViewCell.self, for: indexPath)
            cell.configure(viewData: item)
            return cell
        }
    }

    func configureDataSource() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, FilterViewData>()
        snapshot.appendSections([.main])
        FixFilterLabelType.allCases.forEach({
            switch $0 {
            case .all:
                let filterItems = FilterViewData(type: .all, state: .selected)
                snapshot.appendItems([filterItems])
            case .art:
                let filterItems = FilterViewData(type: .art, state: .normal)
                snapshot.appendItems([filterItems])
            case .club:
                let filterItems = FilterViewData(type: .club, state: .normal)
                snapshot.appendItems([filterItems])
            case .banquet:
                let filterItems = FilterViewData(type: .banquet, state: .normal)
                snapshot.appendItems([filterItems])
            case .wellness:
                let filterItems = FilterViewData(type: .wellness, state: .normal)
                snapshot.appendItems([filterItems])
            case .workshop:
                let filterItems = FilterViewData(type: .workshop, state: .normal)
                snapshot.appendItems([filterItems])
            case .meeting:
                let filterItems = FilterViewData(type: .meeting, state: .normal)
                snapshot.appendItems([filterItems])
            }
        })

        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: false)
        }
    }

    func reloadFilterLabelDataSource(indexPath: IndexPath, state: FilterState) {
        var snapshot = dataSource.snapshot()
        guard let selectedItem = dataSource.itemIdentifier(for: indexPath) else { return }
        selectedItem.state = state
        snapshot.reloadItems([selectedItem])
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: false)
        }
    }
}
extension FixFilterView {
    private enum Section {
        case main
    }
}

