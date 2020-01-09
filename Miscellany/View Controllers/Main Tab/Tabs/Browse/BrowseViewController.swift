//
//  SearchViewController.swift
//  Miscellany
//
//  Created by Theodore Gallao on 10/8/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

// MARK: Section
extension BrowseViewController {
    enum Section {
        case browseGeneral
        case genres
    }
    
    struct SectionInfo {
        var section: Section
        private(set) var title: String
        private(set) var subtitle: String
        private(set) var indicatorStyle: SectionHeaderCollectionReusableView.IndicatorStyle
        
        init(section: Section) {
            self.section = section
            
            switch section {
            case .browseGeneral:
                self.title = ""
                self.subtitle = ""
                self.indicatorStyle = .none
            case .genres:
                self.title = "Genres"
                self.subtitle = "Look for stories by these genres"
                self.indicatorStyle = .none
            }
        }
    }
}

// MARK: Item and Cells
extension BrowseViewController {
    struct Item: Hashable {
        enum DataType {
            case general
            case genre
        }
        
        var section: Section
        var type: DataType
        var targetId: String
    }
    
    enum CellReuseIdentifier: String {
        case general = "__GENERAL_COLLECTION_VIEW_CELL_ID__"
        case user = "__USER_COLLECTION_VIEW_CELL_ID__"
        case genre = "__GENRE_COLLECTION_VIEW_CELL_ID__"
    }
    
    enum ReusableViewIdentifier: String {
        case sectionHeader = "__SECTION_HEADER_COLLECTION_REUSABLE_VIEW__"
    }
    
    enum ReusableViewKind: String {
        case sectionHeader = "__SECTION_HEADER_COLLECTION_REUSABLE_VIEW_KIND__"
    }
}

class BrowseViewController: BaseViewController {
    private lazy var searchController: UISearchController = {
        let searchViewController = SearchViewController()
        
        let searchController = UISearchController(searchResultsController: searchViewController)
        searchController.delegate = searchViewController
        searchController.searchBar.delegate = searchViewController
        searchController.searchResultsUpdater = searchViewController
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.showsSearchResultsController = true
        //searchController.automaticallyShowsSearchResultsController = true
        searchController.searchBar.placeholder = "Search Miscellany"
        
        return searchController
    }()
    
    
    private lazy var dataProvider: BrowseDataProvider = {
        let dataProvider = BrowseDataProvider()
        dataProvider.delegate = self
        
        return dataProvider
    }()
    
    // MARK: Collection View
    private(set) lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.collectionViewLayout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.isScrollEnabled = true
        collectionView.alwaysBounceVertical = true
        collectionView.isScrollEnabled = true
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(GeneralCollectionViewCell.self, forCellWithReuseIdentifier: CellReuseIdentifier.general.rawValue)
        collectionView.register(UserCollectionViewCell.self, forCellWithReuseIdentifier: CellReuseIdentifier.user.rawValue)
        collectionView.register(GenreCollectionViewCell.self, forCellWithReuseIdentifier: CellReuseIdentifier.genre.rawValue)
        
        collectionView.register(SectionHeaderCollectionReusableView.self, forSupplementaryViewOfKind: ReusableViewKind.sectionHeader.rawValue, withReuseIdentifier: ReusableViewIdentifier.sectionHeader.rawValue)
        
        return collectionView
    }()
    
    // MARK: Collection View Layout
    private lazy var collectionViewLayout: UICollectionViewCompositionalLayout = {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .vertical
        configuration.interSectionSpacing = self.displayMode.spacing + 20
        
        return UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let section = self.dataProvider.sections[sectionIndex]
            let item = self.layoutItem(for: section)
            let group = self.layoutGroup(for: section, with: item)
            
            return self.layoutSection(for: section, with: group)
            
        }, configuration: configuration)
    }()
    
    // MARK: Collection View Data Source
    private lazy var dataSource: UICollectionViewDiffableDataSource<Section, Item> = {
        let collectionView = self.collectionView
        
        // MARK: Cell
        let dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView)
        { (collectionView, indexPath, item) -> UICollectionViewCell? in
            switch item.type {
            case .general:
                guard
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellReuseIdentifier.general.rawValue, for: indexPath) as? GeneralCollectionViewCell,
                    let general = self.dataProvider.general[item.targetId]
                else {fatalError("ERROR: Unable to make cell")}
                
                cell.set(general: general)
                return cell
            case .genre:
                guard
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellReuseIdentifier.genre.rawValue, for: indexPath) as? GenreCollectionViewCell,
                    let baseGenre = self.dataProvider.genres[item.targetId]
                else {fatalError("ERROR: Unable to make cell")}
                
                cell.set(baseGenre: baseGenre)
                return cell
            }
        }
        
        // MARK: Supplementary
        dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath) -> UICollectionReusableView? in
            if // Section Header
                kind == ReusableViewKind.sectionHeader.rawValue,
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ReusableViewIdentifier.sectionHeader.rawValue, for: indexPath) as? SectionHeaderCollectionReusableView {
                let title: String
                let subtitle: String
                let indicatorStyle: SectionHeaderCollectionReusableView.IndicatorStyle
                let section = self.dataProvider.sections[indexPath.section]
                let sectionInfo = SectionInfo(section: section)
                
                header.set(title: sectionInfo.title, subtitle: sectionInfo.subtitle, indicatorStyle: sectionInfo.indicatorStyle)
                
                return header
            } else {
                return nil
            }
        }
        
        return dataSource
    }()
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        activityIndicator.tintColor = UIColor(named: "Text")
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        return activityIndicator
    }()
    
    // Constraint Variables
    var activityIndicatorViewConstraints = [NSLayoutConstraint]()
    var collectionViewConstraints = [NSLayoutConstraint]()
    
    // MARK: Initializers
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: View Controller States
extension BrowseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.activityIndicatorView.startAnimating()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.dataProvider.startObserving()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.dataProvider.stopObserving()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { _ in
            self.configureLayout()
            self.collectionView.collectionViewLayout.invalidateLayout()
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}

// MARK: Properties
extension BrowseViewController {
    override func configureProperties() {
        super.configureProperties()
        
        self.extendedLayoutIncludesOpaqueBars = true
        self.edgesForExtendedLayout = [.top]
    }
}

// MARK: Additional
extension BrowseViewController {
    override func configureAdditional() {
        super.configureAdditional()
    }
}

// MARK: Views, Layout & Constraints
extension BrowseViewController {
    override func configureViews() {
        super.configureViews()
        
        self.view.backgroundColor = UIColor(named: "Background")
        
        self.view.addSubview(self.collectionView)
        self.view.addSubview(self.activityIndicatorView)
    }
    
    override func configureLayout() {
        super.configureLayout()
        
        let spacing = self.displayMode.spacing
        
        self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: spacing, right: 0)
        self.view.directionalLayoutMargins = self.displayMode.directionalLayoutMargins
        self.navigationController?.navigationBar.directionalLayoutMargins = self.displayMode.directionalLayoutMargins
    }
    
    override func deactivateConstraints() {
        super.deactivateConstraints()
        
        NSLayoutConstraint.deactivate(self.activityIndicatorViewConstraints)
        NSLayoutConstraint.deactivate(self.collectionViewConstraints)
    }
    
    override func activateConstraints() {
        super.activateConstraints()
        
        NSLayoutConstraint.activate(self.activityIndicatorViewConstraints)
        NSLayoutConstraint.activate(self.collectionViewConstraints)
    }
    
    override func configureLayoutForCompactSizeClass() {
        super.configureLayoutForCompactSizeClass()
        
        self.activityIndicatorViewConstraints = [
            self.activityIndicatorView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.activityIndicatorView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ]
        
        self.collectionViewConstraints = [
            self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ]
    }
    
    override func configureLayoutForRegularSizeClass() {
        super.configureLayoutForRegularSizeClass()
        
        self.activityIndicatorViewConstraints = [
            self.activityIndicatorView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.activityIndicatorView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ]
        
        self.collectionViewConstraints = [
            self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ]
    }
}

// MARK: Navigation
extension BrowseViewController {
    var topbarHeight: CGFloat {
        return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
    
    override func configureNavigation(_ animated: Bool) {
        super.configureNavigation(animated)
        
        self.navigationItem.title = "Browse"
        self.navigationItem.searchController = self.searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
        if let navigationController = self.navigationController {
            navigationController.hidesBarsOnSwipe = false
            navigationController.hidesBarsOnTap = false
            navigationController.setToolbarHidden(true, animated: animated)
            navigationController.navigationBar.tintColor = UIColor(named: "Primary")
        }
    }
}

// MARK: Collection View Layout
extension BrowseViewController {
    
    
    // MARK: Layout Item
    private func layoutItem(for section: Section) -> NSCollectionLayoutItem {
        return NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)))
    }

    // MARK: Layout Group
    private func layoutGroup(for section: Section, with item: NSCollectionLayoutItem) -> NSCollectionLayoutGroup {
        let numberOfRows: CGFloat
        let numberOfColumns: CGFloat
        let heightMultiplier: CGFloat
        let heightConstant: CGFloat
        
        switch section {
        case .browseGeneral:
            numberOfRows = 1
            heightMultiplier = 0
            switch self.displayMode {
            case .compact:
                heightConstant = 54
                numberOfColumns = 1
            case .standard:
                heightConstant = 56
                numberOfColumns = 1
            case .large:
                heightConstant = 58
                numberOfColumns = 2
            case .extraLarge:
                heightConstant = 60
                numberOfColumns = 2
            }
        case .genres:
            numberOfRows = 1
            heightMultiplier = 2 / 3
            heightConstant = 44
            switch self.displayMode {
            case .compact:
                numberOfColumns = 2
            case .standard:
                numberOfColumns = 2
            case .large:
                numberOfColumns = 3
            case .extraLarge:
                numberOfColumns = 4
            }
        }
        
        let marginedWidth = self.view.layoutMarginsGuide.layoutFrame.width
        let spacing = self.displayMode.spacing
        
        // width
        let widthAfterSpacing = marginedWidth - (spacing * (numberOfColumns - 1))
        let width = widthAfterSpacing / numberOfColumns
        
        // height
        let heightOfRows = (width * heightMultiplier + heightConstant) * numberOfRows
        let heightOfSpacing = spacing * (numberOfRows - 1)
        let height = heightOfRows + heightOfSpacing
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(marginedWidth),
            heightDimension: .absolute(height))
        // Since this group lays out horizontally, the item count is based on the number of columns
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: Int(numberOfColumns))
        group.interItemSpacing = .fixed(spacing)
        
        return group
    }

    // MARK: Layout Section
    private func layoutSection(for section: Section, with group: NSCollectionLayoutGroup) -> NSCollectionLayoutSection {
        let groupSpacing = self.displayMode.spacing
        
        let layoutSection = NSCollectionLayoutSection(group: group)
        layoutSection.orthogonalScrollingBehavior = .none
        layoutSection.interGroupSpacing = groupSpacing
        layoutSection.contentInsets = self.displayMode.directionalLayoutMargins
        
        if let header = self.sectionHeader(for: section) {
            layoutSection.boundarySupplementaryItems = [header]
        }
        
        return layoutSection
    }
    
    // MARK: Section Header
    private func sectionHeader(for section: Section) -> NSCollectionLayoutBoundarySupplementaryItem? {
        if section == .browseGeneral {
            return nil
        }
        
        let yOffset: CGFloat = -self.displayMode.spacing
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: ReusableViewKind.sectionHeader.rawValue,
            alignment: .top,
            absoluteOffset: CGPoint(x: 0, y: yOffset))
        header.pinToVisibleBounds = false
        
        return header
    }
}

// MARK: Collection View Delegate
extension BrowseViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard
//            let section = self.dataProvider.sections[optional: indexPath.section],
//            let items = self.dataProvider.items(for: section),
//            let item = items[optional: indexPath.item] else
//        {
//            print("Nope - ", indexPath)
//            return
//        }
//
//
    }
}

extension BrowseViewController: BrowseDataProviderDelegate {
    func browseDataProviderDidUpdate(_ browseDataProvider: BrowseDataProvider) {
        self.updateCollectionView(animated: true)
    }
}

// MARK: Selectors
extension BrowseViewController {
    func updateCollectionView(animated: Bool) {
        DispatchQueue(label: "Collection View Updates", qos: .utility).async { [weak self] in
            guard let sections = self?.dataProvider.sections else { return }
            
            var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
            snapshot.appendSections(sections)
            
            sections.forEach { [weak self] (section) in
                guard let items = self?.dataProvider.items(for: section) else { return }
                
                if section == .genres {
                    let filteredGenres = items.filter { $0.targetId != "000" }
                    
                    snapshot.appendItems(filteredGenres, toSection: section)
                } else {
                    snapshot.appendItems(items, toSection: section)
                }
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.activityIndicatorView.stopAnimating()
                self?.dataSource.apply(snapshot, animatingDifferences: animated)
            }
        }
    }
}

