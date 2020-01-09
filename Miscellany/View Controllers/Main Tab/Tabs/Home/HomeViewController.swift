//
//  HomeViewController.swift
//  Miscellany
//
//  Created by Theodore Gallao on 6/11/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

// MARK: Section
extension HomeViewController {
    enum Section {
        case headline
        case recommendedForYou
        case authorsForYou
        case newForYou
        case tagsForYou
        case newAndTrending
        case topCharts
        case ourFavorites
        case popularAuthors
        case popularTags
        case genres
        case contests
    }
    
    struct SectionInfo {
        var section: Section
        private(set) var title: String
        private(set) var subtitle: String
        private(set) var indicatorStyle: SectionHeaderCollectionReusableView.IndicatorStyle
        
        init(section: Section) {
            self.section = section
            
            switch section {
            case .headline:
                self.title = ""
                self.subtitle = ""
                self.indicatorStyle = .none
            case .recommendedForYou:
                self.title = "Recommended For You"
                self.subtitle = "We think you'll like these stories"
                self.indicatorStyle = .more
            case .authorsForYou:
                self.title = "Authors For You"
                self.subtitle = "You might be interested in their work"
                self.indicatorStyle = .more
            case .newForYou:
                self.title = "New For You"
                self.subtitle = "From your subscriptions and favorite genres"
                self.indicatorStyle = .more
            case .tagsForYou:
                self.title = "Tags For You"
                self.subtitle = "You might these like kinds of stories"
                self.indicatorStyle = .more
            case .newAndTrending:
                self.title = "New & Trending"
                self.subtitle = "Fresh stories on the rise"
                self.indicatorStyle = .more
            case .topCharts:
                self.title = "Top Charts"
                self.subtitle = "The very best of this week"
                self.indicatorStyle = .more
            case .ourFavorites:
                self.title = "Our Favorites"
                self.subtitle = "Stories that we love right now"
                self.indicatorStyle = .more
            case .popularAuthors:
                self.title = "Popular Authors"
                self.subtitle = "People like reading stories they've written"
                self.indicatorStyle = .more
            case .popularTags:
                self.title = "Popular Tags"
                self.subtitle = "People like reading these kinds of stories lately"
                self.indicatorStyle = .more
            case .genres:
                self.title = "Genres"
                self.subtitle = "Look for stories by these genres"
                self.indicatorStyle = .more
            case .contests:
                self.title = "Contests"
                self.subtitle = "Results for Miscellany's monthly contests"
                self.indicatorStyle = .more
            }
        }
    }
}

// MARK: Item and Cells
extension HomeViewController {
    struct Item: Hashable {
        enum DataType {
            case story
            case rankedStory
            case user
            case headline
            case genre
            case tag
        }
        
        var section: Section
        var type: DataType
        var targetId: String
        var secondaryTargetId: String? = nil
    }
    
    enum CellReuseIdentifier: String {
        case headline = "__HEADLINE_COLLECTION_VIEW_CELL_ID__"
        case story = "__STORY_COLLECTION_VIEW_CELL_ID__"
        case rankedStory = "__RANKED_STORY_COLLECTION_VIEW_CELL_ID__"
        case user = "__USER_COLLECTION_VIEW_CELL_ID__"
        case tag = "__TAG_COLLECTION_VIEW_CELL_ID__"
        case genre = "__GENRE_COLLECTION_VIEW_CELL_ID__"
    }
    
    enum ReusableViewIdentifier: String {
        case sectionHeader = "__SECTION_HEADER_COLLECTION_REUSABLE_VIEW__"
        case groupHeader = "__GROUP_HEADER_COLLECTION_REUSABLE_VIEW__"
    }
    
    enum ReusableViewKind: String {
        case sectionHeader = "__SECTION_HEADER_COLLECTION_REUSABLE_VIEW_KIND__"
        case groupHeader = "__GROUP_HEADER_COLLECTION_REUSABLE_VIEW_KIND__"
    }
}

final class HomeViewController: BaseViewController {
    private lazy var dataProvider: HomeDataProvider = {
        let dataProvider = HomeDataProvider()
        dataProvider.delegate = self
        
        return dataProvider
    }()
    
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
        
        collectionView.register(HeadlineCollectionViewCell.self, forCellWithReuseIdentifier: CellReuseIdentifier.headline.rawValue)
        collectionView.register(StoryCollectionViewCell.self, forCellWithReuseIdentifier: CellReuseIdentifier.story.rawValue)
        collectionView.register(RankedStoryCollectionViewCell.self, forCellWithReuseIdentifier: CellReuseIdentifier.rankedStory.rawValue)
        collectionView.register(UserCollectionViewCell.self, forCellWithReuseIdentifier: CellReuseIdentifier.user.rawValue)
        collectionView.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: CellReuseIdentifier.tag.rawValue)
        collectionView.register(GenreCollectionViewCell.self, forCellWithReuseIdentifier: CellReuseIdentifier.genre.rawValue)
        
        collectionView.register(SectionHeaderCollectionReusableView.self, forSupplementaryViewOfKind: ReusableViewKind.sectionHeader.rawValue, withReuseIdentifier: ReusableViewIdentifier.sectionHeader.rawValue)
        collectionView.register(GroupHeaderCollectionReusableView.self, forSupplementaryViewOfKind: ReusableViewKind.groupHeader.rawValue, withReuseIdentifier: ReusableViewIdentifier.groupHeader.rawValue)
        
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
            case .headline:
                guard
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellReuseIdentifier.headline.rawValue, for: indexPath) as? HeadlineCollectionViewCell,
                    let headline = self.dataProvider.headlines[item.targetId]
                else { fatalError("ERROR: Unable to make cell") }
                
                cell.set(headline: headline)
                return cell
            case .story:
                guard
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellReuseIdentifier.story.rawValue, for: indexPath) as? StoryCollectionViewCell,
                    let baseStory = self.dataProvider.stories[item.targetId]
                else { fatalError("ERROR: Unable to make cell") }
                
                cell.set(baseStory: baseStory)
                return cell
            case .rankedStory:
                guard
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellReuseIdentifier.rankedStory.rawValue, for: indexPath) as? RankedStoryCollectionViewCell,
                    let baseStory = self.dataProvider.stories[item.targetId]
                else { fatalError("ERROR: Unable to make cell") }
                
                cell.set(baseStory: baseStory, rank: (indexPath.item % 5) + 1)
                return cell
            case .user:
                guard
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellReuseIdentifier.user.rawValue, for: indexPath) as? UserCollectionViewCell,
                    let baseUser = self.dataProvider.users[item.targetId]
                else {fatalError("ERROR: Unable to make cell")}
                
                cell.set(baseUser: baseUser)
                return cell
            case .tag:
                guard
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellReuseIdentifier.tag.rawValue, for: indexPath) as? TagCollectionViewCell,
                    let baseTag = self.dataProvider.tags[item.targetId]
                else {fatalError("ERROR: Unable to make cell")}
                
                cell.set(baseTag: baseTag)
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
            } else if // Group Header
                kind == ReusableViewKind.groupHeader.rawValue,
                let groupHeader = collectionView.dequeueReusableSupplementaryView(ofKind: ReusableViewKind.groupHeader.rawValue, withReuseIdentifier: ReusableViewIdentifier.groupHeader.rawValue, for: indexPath) as? GroupHeaderCollectionReusableView,
                let section = self.dataProvider.sections[optional: indexPath.section],
                let items = self.dataProvider.items(for: section),
                let item = items[optional: indexPath.item * 5],
                let secondaryTargetId = item.secondaryTargetId
            {
                let title: String
                if section == .topCharts, let genre = self.dataProvider.genres[secondaryTargetId] {
                    title = genre.title
                } else if section == .contests, let contest = self.dataProvider.contests[secondaryTargetId] {
                    title = contest.title
                } else {
                    title = ""
                }
                
                groupHeader.set(title: title)
                return groupHeader
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

// MARK: Properties
extension HomeViewController {
    override func configureProperties() {
        super.configureProperties()
        
        // Extend layout past navigation and tab bars
        self.extendedLayoutIncludesOpaqueBars = true
        self.edgesForExtendedLayout = [.top, .bottom]
    }
}

// MARK: View Layout & Constraints
extension HomeViewController {
    override func configureViews() {
        super.configureViews()
        
        self.view.backgroundColor = UIColor(named: "Background")
        
        self.view.addSubview(self.collectionView)
        self.view.addSubview(self.activityIndicatorView)
    }
    
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
extension HomeViewController {
    var topbarHeight: CGFloat {
        return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
    
    override func configureNavigation(_ animated: Bool) {
        super.configureNavigation(animated)
        
        self.navigationItem.title = "Home"
        
        if let navigationController = self.navigationController {
            
            navigationController.hidesBarsOnSwipe = false
            navigationController.hidesBarsOnTap = false
            navigationController.setToolbarHidden(true, animated: animated)
            navigationController.navigationBar.tintColor = UIColor(named: "Primary")
        }
    }
}

// MARK: Collection View Layout
extension HomeViewController {
    
    
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
        case .headline:
            numberOfRows = 1
            heightMultiplier = 2 / 3
            heightConstant = 74
            switch self.displayMode {
            case .compact:
                numberOfColumns = 1
            case .standard:
                numberOfColumns = 1
            case .large:
                numberOfColumns = 1 + (1 / 3)
            case .extraLarge:
                numberOfColumns = 2
            }
        case .recommendedForYou, .newForYou, .newAndTrending, .ourFavorites:
            numberOfRows = 1
            heightMultiplier = 3 / 2
            heightConstant = 44
            switch self.displayMode {
            case .compact:
                numberOfColumns = 2
            case .standard:
                numberOfColumns = 3
            case .large:
                numberOfColumns = 4
            case .extraLarge:
                numberOfColumns = 5
            }
        case .topCharts, .contests:
            numberOfRows = 5
            heightMultiplier = 0
            switch displayMode {
            case .compact:
                numberOfColumns = 1
                heightConstant = 60
            case .standard:
                numberOfColumns = 1.5
                heightConstant = 62
            case .large:
                numberOfColumns = 2
                heightConstant = 64
            case .extraLarge:
                numberOfColumns = 2.5
                heightConstant = 66
            }
        case .authorsForYou, .tagsForYou, .popularTags, .popularAuthors:
            numberOfRows = 3
            heightMultiplier = 0
            switch displayMode {
            case .compact:
                numberOfColumns = 1
                heightConstant = 54
            case .standard:
                numberOfColumns = 1.5
                heightConstant = 56
            case .large:
                numberOfColumns = 2
                heightConstant = 58
            case .extraLarge:
                numberOfColumns = 2.5
                heightConstant = 60
            }
        case .genres:
            numberOfRows = 2
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
            widthDimension: .absolute(width),
            heightDimension: .absolute(height))
        // Since this group lays out vertically, the item count is based on the number of rows
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitem: item,
            count: Int(numberOfRows))
        group.interItemSpacing = .fixed(spacing)
        
        if let groupHeader = self.groupHeader(for: section) {
            group.supplementaryItems = [groupHeader]
        }
        
        return group
    }

    // MARK: Layout Section
    private func layoutSection(for section: Section, with group: NSCollectionLayoutGroup) -> NSCollectionLayoutSection {
        let groupSpacing = self.displayMode.spacing
        let orthogonalScrollingBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior
        switch section {
        case .headline, .contests, .topCharts, .authorsForYou, .tagsForYou, .popularAuthors, .popularTags:
            orthogonalScrollingBehavior = .groupPaging
        default:
            orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        }
        
        let layoutSection = NSCollectionLayoutSection(group: group)
        layoutSection.orthogonalScrollingBehavior = orthogonalScrollingBehavior
        layoutSection.interGroupSpacing = groupSpacing
        layoutSection.contentInsets = self.displayMode.directionalLayoutMargins
        
        if let header = self.sectionHeader(for: section) {
            layoutSection.boundarySupplementaryItems = [header]
        }
        
        return layoutSection
    }
    
    // MARK: Section Header
    private func sectionHeader(for section: Section) -> NSCollectionLayoutBoundarySupplementaryItem? {
        if section == .headline {
            return nil
        }
        
        var yOffset: CGFloat = -self.displayMode.spacing
        
        // Must give space for group header
        if section == .topCharts || section == .contests {
            yOffset -= 30
        }
        
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
    
    // MARK: Group Header
    private func groupHeader(for section: Section) -> NSCollectionLayoutSupplementaryItem? {
        if !(section == .topCharts || section == .contests) {
            return nil
        }
        
        let numberOfColumns: CGFloat
        switch displayMode {
        case .compact:
            numberOfColumns = 1
        case .standard:
            numberOfColumns = 1.5
        case .large:
            numberOfColumns = 2
        case .extraLarge:
            numberOfColumns = 2.5
        }
        
        let marginedWidth = self.view.layoutMarginsGuide.layoutFrame.width
        let groupSpacing = self.displayMode.spacing
        let width = ((marginedWidth - (groupSpacing * (numberOfColumns - 1))) / numberOfColumns)
        
        let anchor = NSCollectionLayoutAnchor(
            edges: .top,
            absoluteOffset: CGPoint(x: 0, y: -(20 + self.displayMode.spacing)))
        let size = NSCollectionLayoutSize(
            widthDimension: .absolute(width),
            heightDimension: .absolute(20))
        let item = NSCollectionLayoutSupplementaryItem(
            layoutSize: size,
            elementKind: ReusableViewKind.groupHeader.rawValue,
            containerAnchor: anchor)
        
        return item
    }
}

// MARK: Collection View Delegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard
            let section = self.dataProvider.sections[optional: indexPath.section],
            let items = self.dataProvider.items(for: section),
            let item = items[optional: indexPath.item] else
        {
            print("Nope - ", indexPath)
            return
        }
        
        switch item.type {
        case .story, .rankedStory:
            let convertedIndex = indexPath.item % 5
            let lowerBound = indexPath.item - convertedIndex
            let upperBound = lowerBound + 4
            let indices: [Int] = Array(lowerBound...upperBound)
            
            let stories: [BaseStory] = indices.compactMap { index in
                guard let item = items[optional: index] else { return nil }
                return self.dataProvider.stories[item.targetId]
            }
            
            let storyPreviewPageViewController = StoryPreviewPageViewController(stories: stories, firstIndex: convertedIndex)
            storyPreviewPageViewController.hidesBottomBarWhenPushed = true
            
            self.navigationController?.pushViewController(storyPreviewPageViewController, animated: true)
        default:
            break
        }
    }
}

extension HomeViewController: HomeDataProviderDelegate {
    func homeDataProviderDidUpdate(_ homeDataProvider: HomeDataProvider) {
        self.updateCollectionView(animated: true)
    }
}

// MARK: Selectors
extension HomeViewController {
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
