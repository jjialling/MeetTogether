//
//  CalendarDetailViewController.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/3/4.
//

import UIKit

class CalendarDetailViewController: UIViewController {
    
    private lazy var dataSource = makeDataSource()
    
    private let viewModel = EventDetailViewModel()
    
    private var backButton: UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        btn.makeBackStyle()
        btn.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        return btn
    }()
    
    private let eventImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "News_0")
        return imageView
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewlayout)
        collectionView.backgroundColor = .white
        collectionView.layer.cornerRadius = 72
        collectionView.clipsToBounds = true
        collectionView.layer.maskedCorners = [.layerMinXMinYCorner]
        collectionView.register(cellWithClass: EventDetailCollectionViewCell.self)
        collectionView.register(cellWithClass: ContactCollectionViewCell.self)
//        collectionView.delegate = self
        return collectionView
    }()

    private var cardLayoutSection: NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(700))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(700))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 42, trailing: 0)
        return section
    }

    private var contactLayoutSection: NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(0.6))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .estimated(92))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        let section = NSCollectionLayoutSection(group: group)

        return section
    }


    private lazy var collectionViewlayout: UICollectionViewLayout = {
        UICollectionViewCompositionalLayout { [unowned self] index, enviroment in
            let section = Section(rawValue: index) ?? .detail
            switch section {
            case .detail:
                return cardLayoutSection
            case .contact:
                return contactLayoutSection
            }
        }
    }()
    
    private let attendBottomView: AttendBottomView = {
        let view = AttendBottomView()
        return view
    }()
    
    private let eventListID: String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        viewModel.fetchEventDetail(id: eventListID) //繼續放進datasource
        binding()
//        configNavgationBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(eventListID: String) {
        self.eventListID = eventListID
        super.init(nibName: nil, bundle: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }

    private func setUI() {
        view.backgroundColor = .white
        view.addSubviews([eventImageView, backButton, collectionView, attendBottomView])
    
        eventImageView.snp.makeConstraints({
            $0.leading.trailing.top.equalToSuperview()
            $0.height.equalTo(300)
        })
        backButton.snp.makeConstraints({
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(56)
            $0.width.height.equalTo(32)
        })
        collectionView.snp.makeConstraints({
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(eventImageView.snp.bottom).offset(-52)
            $0.bottom.equalTo(attendBottomView.snp.top)
        })
        attendBottomView.snp.makeConstraints({
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(106)
        })
    }
    
    private func binding() {
        configureDataSource()
    }
    
    private func configNavgationBar() {
        setNavBackStyle()
        setNavTransparentStyle()
    }
    
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    }

}
extension CalendarDetailViewController {
    private func makeDataSource() -> UICollectionViewDiffableDataSource<Section, Item> {
        return UICollectionViewDiffableDataSource(collectionView: collectionView) {
            collectionView, indexPath, item in
            switch item {
            case .detail(let model):
                let cell = collectionView.dequeueReusableCell(withClass: EventDetailCollectionViewCell.self, for: indexPath)
                cell.configure(viewData: model)
                cell.delegate = self
                return cell
            case .contact(let model):
                let cell = collectionView.dequeueReusableCell(withClass: ContactCollectionViewCell.self, for: indexPath)
                cell.configure(viewData: model)
                return cell
            }
        }
    }

    private func configureDataSource() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(Section.allCases)
        
        let detailItems = [Item.detail(EventDetailViewData(title: "Brass Ensembles Concert", date: "APRIL 10, 2023, 7 – 8PM", content: "The SWOSU Department of Music prepares students for vibrant careers as music educators, music therapists, and arts administrators. Learn more about our undergraduate and graduate degrees and areas of study below or contact us for additional information."))]
        snapshot.appendItems(detailItems, toSection: .detail)
     
        ContactType.allCases.forEach({
            var value: String?
            switch $0 {
            case .venue:
                value = "Fine Arts Center"
            case .type:
                value = "Arts & Entertainment, Community Event"
            case .organization:
                value = " "
            case .contactName:
                value = "Philip Martinson"
            case .contactEmail:
                value = "philip.martinson@swosu.edu"
            case .contactPhone:
                value = "580-774-3719"
            case .cost:
                value = "$7"
            }

            let contactItems = Item.contact(ContactViewData(title: $0.title, value: value))
            snapshot.appendItems([contactItems], toSection: .contact)
        })

        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: false)
        }
    }
}
extension CalendarDetailViewController {
    private enum Section: Int, CaseIterable {
        case detail = 0
        case contact = 1
    }

    private enum Item: Hashable {
        case detail(EventDetailViewData)
        case contact(ContactViewData)
    }
}
extension CalendarDetailViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
extension CalendarDetailViewController: EventDetailViewDelegate {
    func interestButtonDidTapped() {
        print("interestButtonDidTapped(")
    }
    
    func checkButtonDidTapped() {
        let vc = AttendPeopleViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
