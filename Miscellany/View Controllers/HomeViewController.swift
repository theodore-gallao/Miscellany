//
//  HomeViewController.swift
//  Miscellany
//
//  Created by Theodore Gallao on 6/11/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

// MARK: HomeViewController
final class HomeViewController: BaseViewController {
    // Services
    private let userService: UserService
    private let storyService: StoryService
    private let imageService: ImageService
    
    // Managers
    private let settingsManager: SettingsManager
    
    // Content Data
    private var sections: [SectionModel]?
    private var storyModels: [Section: [StoryModel]]? // [SECTION_ID : STORY_MODEL]
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.collectionViewCompositionalLayout)
        collectionView.backgroundColor = UIColor(named: "Background")
        collectionView.allowsMultipleSelection = false
        collectionView.allowsSelection = true
        collectionView.delaysContentTouches = true
        collectionView.refreshControl = self.refreshControl
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(RegularStoryCollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.Id.regular.rawValue)
        collectionView.register(LargeStoryCollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.Id.large.rawValue)
        collectionView.register(RankedStoryCollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.Id.ranked.rawValue)
        
        collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionReusableView.Kind.header.rawValue, withReuseIdentifier: UICollectionReusableView.Id.header.rawValue)
        collectionView.register(GroupHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionReusableView.Kind.groupHeader.rawValue, withReuseIdentifier: UICollectionReusableView.Id.groupHeader.rawValue)
        
        return collectionView
    }()
    
    private lazy var collectionViewCompositionalLayout: UICollectionViewCompositionalLayout = {
        // The layout will return the appropriate section based on the section
        return UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            guard let sectionModel = self.sections?[optional: sectionIndex] else { return nil }
            
            // Get category and type to determine appropriate section
            let type = sectionModel.displayType
            let item = self.makeCollectionLayoutItem(type: type)
            let group = self.makeCollectionLayoutGroup(type: type, subItem: item)
            let header = self.makeCollectionLayoutHeader()
            let section = self.makeCollectionLayoutSection(type: type, group: group, header: header)
            
            return section
        }
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor(named: "Text")
        refreshControl.addTarget(self, action: #selector(self.handleRefreshControl(_:)), for: UIControl.Event.valueChanged)
        
        return refreshControl
    }()
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        activityIndicator.tintColor = UIColor(named: "Text")
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        return activityIndicator
    }()
    
    // Constraint Variables
    internal var collectionViewConstraints = [NSLayoutConstraint]()
    internal var activityIndicatorViewConstraints = [NSLayoutConstraint]()
    
    // MARK: Initializers
    init(userService: UserService, storyService: StoryService, imageService: ImageService, settingsManager: SettingsManager) {
        self.userService = userService
        self.storyService = storyService
        self.imageService = imageService
        self.settingsManager = settingsManager
        
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
    
    override func configureLayout() {
        super.configureLayout()
        
        NSLayoutConstraint.deactivate(self.collectionViewConstraints)
        NSLayoutConstraint.deactivate(self.activityIndicatorViewConstraints)
        
        self.collectionViewConstraints = [
            self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
        ]
        
        self.activityIndicatorViewConstraints = [
            self.activityIndicatorView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            self.activityIndicatorView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0)
        ]
        
        NSLayoutConstraint.activate(self.collectionViewConstraints)
        NSLayoutConstraint.activate(self.activityIndicatorViewConstraints)
    }
}

// MARK: Additional
extension HomeViewController {
    override func configureAdditional() {
        super.configureAdditional()
        
        self.load(completion: nil)
    }
}

// MARK: Navigation
extension HomeViewController {
    override func configureNavigation(_ animated: Bool) {
        super.configureNavigation(animated)
        
        self.navigationItem.title = "Home"
        
        if let navigationController = self.navigationController {
            navigationController.hidesBarsOnSwipe = false
            navigationController.hidesBarsOnTap = false
            navigationController.setToolbarHidden(true, animated: animated)
        }
    }
}

// MARK: Collection Layout
extension HomeViewController {
    private func makeCollectionLayoutItem(type: SectionDisplayType) -> NSCollectionLayoutItem {
        let itemSize: NSCollectionLayoutSize
        
        if type == .regular {
            itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0))
        } else if type == .large {
            itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0))
        } else {
            itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.2))
        }
        
        return NSCollectionLayoutItem(layoutSize: itemSize)
    }
    
    private func makeCollectionLayoutGroup(type: SectionDisplayType, subItem: NSCollectionLayoutItem) -> NSCollectionLayoutGroup {
        let marginedWidth = self.view.layoutMarginsGuide.layoutFrame.width
        let spacing: CGFloat = 10
        let aspectRatio: CGFloat = 1.6
        let width: CGFloat
        let height: CGFloat
        let itemCount: Int
        let contentInsets: NSDirectionalEdgeInsets
        let supplementaryItems: [NSCollectionLayoutSupplementaryItem]
        
        if self.traitCollection.horizontalSizeClass == .compact {
            let groupCount: CGFloat
            let totalSpacing: CGFloat
            
            if type == .regular {
                groupCount = 2
                totalSpacing = (spacing * (groupCount - 1))
                width = (marginedWidth - totalSpacing) / groupCount
                height = (width * aspectRatio) + 44
                itemCount = 1
                contentInsets = NSDirectionalEdgeInsets.zero
                supplementaryItems = []
            } else if type == .large {
                groupCount = 1
                totalSpacing = (spacing * (groupCount - 1))
                width = (marginedWidth - totalSpacing) / groupCount
                height = (width * aspectRatio) + 44
                itemCount = 1
                contentInsets = NSDirectionalEdgeInsets.zero
                supplementaryItems = []
            } else {
                groupCount = 1
                totalSpacing = (spacing * (groupCount - 1))
                width = (marginedWidth - totalSpacing) / groupCount
                height = 380
                itemCount = 5
                contentInsets = NSDirectionalEdgeInsets(
                    top: 32,
                    leading: 0,
                    bottom: 20,
                    trailing: 0)
                supplementaryItems = [self.makeCollectionLayoutGroupHeader()]
            }
        } else {
            let groupCount: CGFloat
            let totalSpacing: CGFloat
            
            if type == .regular {
                groupCount = 4
                totalSpacing = (spacing * (groupCount - 1))
                width = (marginedWidth - totalSpacing) / groupCount
                height = (width * aspectRatio) + 44
                itemCount = 1
                contentInsets = NSDirectionalEdgeInsets.zero
                supplementaryItems = []
            } else if type == .large {
                groupCount = 2
                totalSpacing = (spacing * (groupCount - 1))
                width = (marginedWidth - totalSpacing) / groupCount
                height = (width * aspectRatio) + 44
                itemCount = 1
                contentInsets = NSDirectionalEdgeInsets.zero
                supplementaryItems = []
            } else {
                groupCount = 2
                totalSpacing = (spacing * (groupCount - 1))
                width = (marginedWidth - totalSpacing) / groupCount
                height = 460
                itemCount = 5
                contentInsets = NSDirectionalEdgeInsets(
                    top: 32,
                    leading: 0,
                    bottom: 20,
                    trailing: 0)
                supplementaryItems = [self.makeCollectionLayoutGroupHeader()]
            }
        }
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(width),
            heightDimension: .absolute(height))
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitem: subItem,
            count: itemCount)
        group.interItemSpacing = .fixed(spacing)
        group.contentInsets = contentInsets
        group.supplementaryItems = supplementaryItems
        
        return group
    }
    
    private func makeCollectionLayoutSection(type: SectionDisplayType, group: NSCollectionLayoutGroup, header: NSCollectionLayoutBoundarySupplementaryItem) -> NSCollectionLayoutSection {
        let boundarySupplementaryItems = [header]
        let contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: self.view.layoutMargins.left,
            bottom: 0,
            trailing: self.view.layoutMargins.right)
        let orthogonalScrollingBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior =
            type == .regular ?
                .continuousGroupLeadingBoundary :
                .groupPaging
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = orthogonalScrollingBehavior
        section.boundarySupplementaryItems = boundarySupplementaryItems
        section.contentInsets = contentInsets
        section.interGroupSpacing = 10
        
        return section
    }
    
    private func makeCollectionLayoutGroupHeader() -> NSCollectionLayoutSupplementaryItem {
        let marginedWidth = self.view.layoutMarginsGuide.layoutFrame.width
        let absoluteOffset = CGPoint(
            x: 0,
            y: -5)
        let width = self.traitCollection.horizontalSizeClass == .compact ?
            marginedWidth :
            (marginedWidth - 10) / 2
        let groupHeaderSize = NSCollectionLayoutSize(
            widthDimension: .absolute(width),
            heightDimension: .absolute(32))
        let groupHeader = NSCollectionLayoutSupplementaryItem(
            layoutSize: groupHeaderSize,
            elementKind: UICollectionReusableView.Kind.groupHeader.rawValue,
            containerAnchor: NSCollectionLayoutAnchor(
                edges: .top,
                absoluteOffset: absoluteOffset))
        
        return groupHeader
    }
    
    private func makeCollectionLayoutHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionReusableView.Kind.header.rawValue,
            alignment: .top)
        header.pinToVisibleBounds = false
        
        return header
    }
}

// MARK: Collection View
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let sections = self.sections else { return 0 }
        
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard
            let section = self.sections?[optional: section],
            let storyModels = self.storyModels?[section.type] else
        {
            return 0
        }
        
        return storyModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let section = self.sections?[optional: indexPath.section],
            let storyModels = self.storyModels?[section.type],
            let storyModel = storyModels[optional: indexPath.row] else
        {
            return UICollectionViewCell()
        }
        
        let cell: UICollectionViewCell
        
        if section.displayType == .regular {
            // Regular
            let regularCell = collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell.Id.regular.rawValue, for: indexPath) as! RegularStoryCollectionViewCell
            regularCell.set(storyModel, imageService: self.imageService)
            
            cell = regularCell
            
        } else if section.displayType == .large {
            // Large
            let largeCell = collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell.Id.large.rawValue, for: indexPath) as! LargeStoryCollectionViewCell
            largeCell.set(storyModel, imageService: self.imageService)
            
            cell = largeCell
        } else {
            // Ranked
            let compactCell = collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell.Id.ranked.rawValue, for: indexPath) as! RankedStoryCollectionViewCell
            compactCell.set(storyModel, imageService: self.imageService)
            compactCell.set(indexPath.row % 5 + 1)
            
            cell = compactCell
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard
            let section = self.sections?[optional: indexPath.section],
            let storyModels = self.storyModels?[section.type]
        else {
            return
        }
        
        let storyPreviewViewController = StoryPreviewViewController(firstIndex: indexPath.item, storyModels: storyModels, imageService: self.imageService)
        
        self.navigationController?.pushViewController(storyPreviewViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard
            let section = self.sections?[optional: indexPath.section],
            let storyModel = self.storyModels?[section.type]?[optional: indexPath.row * 5] else
        {
            return UICollectionReusableView()
        }
        
        let reusableView: UICollectionReusableView
        
        if kind == UICollectionReusableView.Kind.header.rawValue {
            let headerReusableView = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionReusableView.Kind.header.rawValue,
                withReuseIdentifier: UICollectionReusableView.Id.header.rawValue,
                for: indexPath) as! HeaderCollectionReusableView
            headerReusableView.set(title: section.name, subtitle: section.description)
            reusableView = headerReusableView
        } else {
            let groupHeaderReusableView = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionReusableView.Kind.groupHeader.rawValue,
                withReuseIdentifier: UICollectionReusableView.Id.groupHeader.rawValue,
                for: indexPath) as! GroupHeaderCollectionReusableView
            groupHeaderReusableView.set(title: storyModel.genre.rawValue.uppercased())
            reusableView = groupHeaderReusableView
        }
        
        return reusableView
    }
}

// MARK: Selectors
extension HomeViewController {
    private func loadData(_ completion: @escaping() -> ()) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.sections = [
                SectionModel(section: .recentlyRead),
                SectionModel(section: .recommendedForYou),
                SectionModel(section: .topStories),
                SectionModel(section: .newStories),
                SectionModel(section: .trendingStories)
            ]
            
            self.storyModels = [
                // Recently Read section
                .recentlyRead: [
                    StoryModel(id: "000", dateCreated: Date(), dateUpdated: Date(), title: "Test Title 0", description: "Test Description 0", author: UserModel(id: "000", dateCreated: Date(), dateUpdated: Date(), firstName: "Test", lastName: "Name 0"), genre: .adventure, tags: nil, text: "Test text 0", viewCount: 0, likeCount: 0, dislikeCount: 0, commentCount: 0, comments: nil),
                    StoryModel(id: "001", dateCreated: Date(), dateUpdated: Date(), title: "Test Title 1", description: "Test Description 0", author: UserModel(id: "001", dateCreated: Date(), dateUpdated: Date(), firstName: "Test", lastName: "Name 1"), genre: .adventure, tags: nil, text: "Test text 1", viewCount: 0, likeCount: 0, dislikeCount: 0, commentCount: 0, comments: nil),
                    StoryModel(id: "002", dateCreated: Date(), dateUpdated: Date(), title: "Test Title 2", description: "Test Description 2", author: UserModel(id: "002", dateCreated: Date(), dateUpdated: Date(), firstName: "Test", lastName: "Name 2"), genre: .adventure, tags: nil, text: "Test text 2", viewCount: 0, likeCount: 0, dislikeCount: 0, commentCount: 0, comments: nil),
                    StoryModel(id: "003", dateCreated: Date(), dateUpdated: Date(), title: "Test Title 3", description: "Test Description 3", author: UserModel(id: "003", dateCreated: Date(), dateUpdated: Date(), firstName: "Test", lastName: "Name 3"), genre: .adventure, tags: nil, text: "Test text 3", viewCount: 0, likeCount: 0, dislikeCount: 0, commentCount: 0, comments: nil),
                    StoryModel(id: "004", dateCreated: Date(), dateUpdated: Date(), title: "Test Title 4", description: "Test Description 4", author: UserModel(id: "004", dateCreated: Date(), dateUpdated: Date(), firstName: "Test", lastName: "Name 4"), genre: .adventure, tags: nil, text: "Test text 4", viewCount: 0, likeCount: 0, dislikeCount: 0, commentCount: 0, comments: nil)
                ],
                
                // Recommended For You section
                .recommendedForYou: [
                    StoryModel(id: "000", dateCreated: Date(), dateUpdated: Date(), title: "Test Title 0", description: "Test Description 0", author: UserModel(id: "000", dateCreated: Date(), dateUpdated: Date(), firstName: "Test", lastName: "Name 0"), genre: .adventure, tags: nil, text: "Test text 0", viewCount: 0, likeCount: 0, dislikeCount: 0, commentCount: 0, comments: nil),
                    StoryModel(id: "001", dateCreated: Date(), dateUpdated: Date(), title: "Test Title 1", description: "Test Description 0", author: UserModel(id: "001", dateCreated: Date(), dateUpdated: Date(), firstName: "Test", lastName: "Name 1"), genre: .adventure, tags: nil, text: "Test text 1", viewCount: 0, likeCount: 0, dislikeCount: 0, commentCount: 0, comments: nil),
                    StoryModel(id: "002", dateCreated: Date(), dateUpdated: Date(), title: "Test Title 2", description: "Test Description 2", author: UserModel(id: "002", dateCreated: Date(), dateUpdated: Date(), firstName: "Test", lastName: "Name 2"), genre: .adventure, tags: nil, text: "Test text 2", viewCount: 0, likeCount: 0, dislikeCount: 0, commentCount: 0, comments: nil),
                    StoryModel(id: "003", dateCreated: Date(), dateUpdated: Date(), title: "Test Title 3", description: "Test Description 3", author: UserModel(id: "003", dateCreated: Date(), dateUpdated: Date(), firstName: "Test", lastName: "Name 3"), genre: .adventure, tags: nil, text: "Test text 3", viewCount: 0, likeCount: 0, dislikeCount: 0, commentCount: 0, comments: nil),
                    StoryModel(id: "004", dateCreated: Date(), dateUpdated: Date(), title: "Test Title 4", description: "Test Description 4", author: UserModel(id: "004", dateCreated: Date(), dateUpdated: Date(), firstName: "Test", lastName: "Name 4"), genre: .adventure, tags: nil, text: "Test text 4", viewCount: 0, likeCount: 0, dislikeCount: 0, commentCount: 0, comments: nil)
                ],
                
                // Top Stories Section
                .topStories: [
                    StoryModel(id: "000", dateCreated: Date(), dateUpdated: Date(), title: "Test Title 0", description: "Test Description 0", author: UserModel(id: "000", dateCreated: Date(), dateUpdated: Date(), firstName: "Test", lastName: "Name 0"), genre: .all, tags: nil, text: "Test text 0", viewCount: 0, likeCount: 0, dislikeCount: 0, commentCount: 0, comments: nil),
                    StoryModel(id: "001", dateCreated: Date(), dateUpdated: Date(), title: "Test Title 1", description: "Test Description 0", author: UserModel(id: "001", dateCreated: Date(), dateUpdated: Date(), firstName: "Test", lastName: "Name 1"), genre: .all, tags: nil, text: "Test text 1", viewCount: 0, likeCount: 0, dislikeCount: 0, commentCount: 0, comments: nil),
                    StoryModel(id: "002", dateCreated: Date(), dateUpdated: Date(), title: "Test Title 2", description: "Test Description 2", author: UserModel(id: "002", dateCreated: Date(), dateUpdated: Date(), firstName: "Test", lastName: "Name 2"), genre: .all, tags: nil, text: "Test text 2", viewCount: 0, likeCount: 0, dislikeCount: 0, commentCount: 0, comments: nil),
                    StoryModel(id: "003", dateCreated: Date(), dateUpdated: Date(), title: "Test Title 3", description: "Test Description 3", author: UserModel(id: "003", dateCreated: Date(), dateUpdated: Date(), firstName: "Test", lastName: "Name 3"), genre: .all, tags: nil, text: "Test text 3", viewCount: 0, likeCount: 0, dislikeCount: 0, commentCount: 0, comments: nil),
                    StoryModel(id: "004", dateCreated: Date(), dateUpdated: Date(), title: "Test Title 4", description: "Test Description 4", author: UserModel(id: "004", dateCreated: Date(), dateUpdated: Date(), firstName: "Test", lastName: "Name 4"), genre: .all, tags: nil, text: "Test text 4", viewCount: 0, likeCount: 0, dislikeCount: 0, commentCount: 0, comments: nil),
                    StoryModel(id: "000", dateCreated: Date(), dateUpdated: Date(), title: "Test Title 0", description: "Test Description 0", author: UserModel(id: "000", dateCreated: Date(), dateUpdated: Date(), firstName: "Test", lastName: "Name 0"), genre: .adventure, tags: nil, text: "Test text 0", viewCount: 0, likeCount: 0, dislikeCount: 0, commentCount: 0, comments: nil),
                    StoryModel(id: "001", dateCreated: Date(), dateUpdated: Date(), title: "Test Title 1", description: "Test Description 0", author: UserModel(id: "001", dateCreated: Date(), dateUpdated: Date(), firstName: "Test", lastName: "Name 1"), genre: .adventure, tags: nil, text: "Test text 1", viewCount: 0, likeCount: 0, dislikeCount: 0, commentCount: 0, comments: nil),
                    StoryModel(id: "002", dateCreated: Date(), dateUpdated: Date(), title: "Test Title 2", description: "Test Description 2", author: UserModel(id: "002", dateCreated: Date(), dateUpdated: Date(), firstName: "Test", lastName: "Name 2"), genre: .adventure, tags: nil, text: "Test text 2", viewCount: 0, likeCount: 0, dislikeCount: 0, commentCount: 0, comments: nil),
                    StoryModel(id: "003", dateCreated: Date(), dateUpdated: Date(), title: "Test Title 3", description: "Test Description 3", author: UserModel(id: "003", dateCreated: Date(), dateUpdated: Date(), firstName: "Test", lastName: "Name 3"), genre: .adventure, tags: nil, text: "Test text 3", viewCount: 0, likeCount: 0, dislikeCount: 0, commentCount: 0, comments: nil),
                    StoryModel(id: "004", dateCreated: Date(), dateUpdated: Date(), title: "Test Title 4", description: "Test Description 4", author: UserModel(id: "004", dateCreated: Date(), dateUpdated: Date(), firstName: "Test", lastName: "Name 4"), genre: .adventure, tags: nil, text: "Test text 4", viewCount: 0, likeCount: 0, dislikeCount: 0, commentCount: 0, comments: nil),
                    StoryModel(id: "000", dateCreated: Date(), dateUpdated: Date(), title: "Test Title 0", description: "Test Description 0", author: UserModel(id: "000", dateCreated: Date(), dateUpdated: Date(), firstName: "Test", lastName: "Name 0"), genre: .dystopian, tags: nil, text: "Test text 0", viewCount: 0, likeCount: 0, dislikeCount: 0, commentCount: 0, comments: nil),
                    StoryModel(id: "001", dateCreated: Date(), dateUpdated: Date(), title: "Test Title 1", description: "Test Description 0", author: UserModel(id: "001", dateCreated: Date(), dateUpdated: Date(), firstName: "Test", lastName: "Name 1"), genre: .dystopian, tags: nil, text: "Test text 1", viewCount: 0, likeCount: 0, dislikeCount: 0, commentCount: 0, comments: nil),
                    StoryModel(id: "002", dateCreated: Date(), dateUpdated: Date(), title: "Test Title 2", description: "Test Description 2", author: UserModel(id: "002", dateCreated: Date(), dateUpdated: Date(), firstName: "Test", lastName: "Name 2"), genre: .dystopian, tags: nil, text: "Test text 2", viewCount: 0, likeCount: 0, dislikeCount: 0, commentCount: 0, comments: nil),
                    StoryModel(id: "003", dateCreated: Date(), dateUpdated: Date(), title: "Test Title 3", description: "Test Description 3", author: UserModel(id: "003", dateCreated: Date(), dateUpdated: Date(), firstName: "Test", lastName: "Name 3"), genre: .dystopian, tags: nil, text: "Test text 3", viewCount: 0, likeCount: 0, dislikeCount: 0, commentCount: 0, comments: nil),
                    StoryModel(id: "004", dateCreated: Date(), dateUpdated: Date(), title: "Test Title 4", description: "Test Description 4", author: UserModel(id: "004", dateCreated: Date(), dateUpdated: Date(), firstName: "Test", lastName: "Name 4"), genre: .dystopian, tags: nil, text: "Test text 4", viewCount: 0, likeCount: 0, dislikeCount: 0, commentCount: 0, comments: nil),
                    StoryModel(id: "000", dateCreated: Date(), dateUpdated: Date(), title: "Test Title 0", description: "Test Description 0", author: UserModel(id: "000", dateCreated: Date(), dateUpdated: Date(), firstName: "Test", lastName: "Name 0"), genre: .fantasy, tags: nil, text: "Test text 0", viewCount: 0, likeCount: 0, dislikeCount: 0, commentCount: 0, comments: nil),
                    StoryModel(id: "001", dateCreated: Date(), dateUpdated: Date(), title: "Test Title 1", description: "Test Description 0", author: UserModel(id: "001", dateCreated: Date(), dateUpdated: Date(), firstName: "Test", lastName: "Name 1"), genre: .fantasy, tags: nil, text: "Test text 1", viewCount: 0, likeCount: 0, dislikeCount: 0, commentCount: 0, comments: nil),
                    StoryModel(id: "002", dateCreated: Date(), dateUpdated: Date(), title: "Test Title 2", description: "Test Description 2", author: UserModel(id: "002", dateCreated: Date(), dateUpdated: Date(), firstName: "Test", lastName: "Name 2"), genre: .fantasy, tags: nil, text: "Test text 2", viewCount: 0, likeCount: 0, dislikeCount: 0, commentCount: 0, comments: nil),
                    StoryModel(id: "003", dateCreated: Date(), dateUpdated: Date(), title: "Test Title 3", description: "Test Description 3", author: UserModel(id: "003", dateCreated: Date(), dateUpdated: Date(), firstName: "Test", lastName: "Name 3"), genre: .fantasy, tags: nil, text: "Test text 3", viewCount: 0, likeCount: 0, dislikeCount: 0, commentCount: 0, comments: nil),
                    StoryModel(id: "004", dateCreated: Date(), dateUpdated: Date(), title: "Test Title 4", description: "Test Description 4", author: UserModel(id: "004", dateCreated: Date(), dateUpdated: Date(), firstName: "Test", lastName: "Name 4"), genre: .fantasy, tags: nil, text: "Test text 4", viewCount: 0, likeCount: 0, dislikeCount: 0, commentCount: 0, comments: nil)
                ],
                
                // New Stories section
                .newStories: [
                    StoryModel(id: "000", dateCreated: Date(), dateUpdated: Date(), title: "Test Title 0", description: "Test Description 0", author: UserModel(id: "000", dateCreated: Date(), dateUpdated: Date(), firstName: "Test", lastName: "Name 0"), genre: .adventure, tags: nil, text: "Test text 0", viewCount: 0, likeCount: 0, dislikeCount: 0, commentCount: 0, comments: nil),
                    StoryModel(id: "001", dateCreated: Date(), dateUpdated: Date(), title: "Test Title 1", description: "Test Description 1", author: UserModel(id: "001", dateCreated: Date(), dateUpdated: Date(), firstName: "Test", lastName: "Name 1"), genre: .adventure, tags: nil, text: "Test text 1", viewCount: 0, likeCount: 0, dislikeCount: 0, commentCount: 0, comments: nil),
                    StoryModel(id: "002", dateCreated: Date(), dateUpdated: Date(), title: "Test Title 2", description: "Test Description 2", author: UserModel(id: "002", dateCreated: Date(), dateUpdated: Date(), firstName: "Test", lastName: "Name 2"), genre: .adventure, tags: nil, text: "Test text 2", viewCount: 0, likeCount: 0, dislikeCount: 0, commentCount: 0, comments: nil),
                    StoryModel(id: "003", dateCreated: Date(), dateUpdated: Date(), title: "Test Title 3", description: "Test Description 3", author: UserModel(id: "003", dateCreated: Date(), dateUpdated: Date(), firstName: "Test", lastName: "Name 3"), genre: .adventure, tags: nil, text: "Test text 3", viewCount: 0, likeCount: 0, dislikeCount: 0, commentCount: 0, comments: nil),
                    StoryModel(id: "004", dateCreated: Date(), dateUpdated: Date(), title: "Test Title 4", description: "Test Description 4", author: UserModel(id: "004", dateCreated: Date(), dateUpdated: Date(), firstName: "Test", lastName: "Name 4"), genre: .adventure, tags: nil, text: "Test text 4", viewCount: 0, likeCount: 0, dislikeCount: 0, commentCount: 0, comments: nil)
                ],
                
                // Trending Stories Section
                .trendingStories: [
                    StoryModel(id: "000", dateCreated: Date(), dateUpdated: Date(), title: "Test Title 0", description: "Test Description 0", author: UserModel(id: "000", dateCreated: Date(), dateUpdated: Date(), firstName: "Test", lastName: "Name 0"), genre: .all, tags: nil, text: "Test text 0", viewCount: 0, likeCount: 0, dislikeCount: 0, commentCount: 0, comments: nil),
                    StoryModel(id: "001", dateCreated: Date(), dateUpdated: Date(), title: "Test Title 1", description: "Test Description 0", author: UserModel(id: "001", dateCreated: Date(), dateUpdated: Date(), firstName: "Test", lastName: "Name 1"), genre: .all, tags: nil, text: "Test text 1", viewCount: 0, likeCount: 0, dislikeCount: 0, commentCount: 0, comments: nil),
                    StoryModel(id: "002", dateCreated: Date(), dateUpdated: Date(), title: "Test Title 2", description: "Test Description 2", author: UserModel(id: "002", dateCreated: Date(), dateUpdated: Date(), firstName: "Test", lastName: "Name 2"), genre: .all, tags: nil, text: "Test text 2", viewCount: 0, likeCount: 0, dislikeCount: 0, commentCount: 0, comments: nil),
                    StoryModel(id: "003", dateCreated: Date(), dateUpdated: Date(), title: "Test Title 3", description: "Test Description 3", author: UserModel(id: "003", dateCreated: Date(), dateUpdated: Date(), firstName: "Test", lastName: "Name 3"), genre: .all, tags: nil, text: "Test text 3", viewCount: 0, likeCount: 0, dislikeCount: 0, commentCount: 0, comments: nil),
                    StoryModel(id: "004", dateCreated: Date(), dateUpdated: Date(), title: "Test Title 4", description: "Test Description 4", author: UserModel(id: "004", dateCreated: Date(), dateUpdated: Date(), firstName: "Test", lastName: "Name 4"), genre: .all, tags: nil, text: "Test text 4", viewCount: 0, likeCount: 0, dislikeCount: 0, commentCount: 0, comments: nil),
                    StoryModel(id: "000", dateCreated: Date(), dateUpdated: Date(), title: "Test Title 0", description: "Test Description 0", author: UserModel(id: "000", dateCreated: Date(), dateUpdated: Date(), firstName: "Test", lastName: "Name 0"), genre: .adventure, tags: nil, text: "Test text 0", viewCount: 0, likeCount: 0, dislikeCount: 0, commentCount: 0, comments: nil),
                    StoryModel(id: "001", dateCreated: Date(), dateUpdated: Date(), title: "Test Title 1", description: "Test Description 0", author: UserModel(id: "001", dateCreated: Date(), dateUpdated: Date(), firstName: "Test", lastName: "Name 1"), genre: .adventure, tags: nil, text: "Test text 1", viewCount: 0, likeCount: 0, dislikeCount: 0, commentCount: 0, comments: nil),
                    StoryModel(id: "002", dateCreated: Date(), dateUpdated: Date(), title: "Test Title 2", description: "Test Description 2", author: UserModel(id: "002", dateCreated: Date(), dateUpdated: Date(), firstName: "Test", lastName: "Name 2"), genre: .adventure, tags: nil, text: "Test text 2", viewCount: 0, likeCount: 0, dislikeCount: 0, commentCount: 0, comments: nil),
                    StoryModel(id: "003", dateCreated: Date(), dateUpdated: Date(), title: "Test Title 3", description: "Test Description 3", author: UserModel(id: "003", dateCreated: Date(), dateUpdated: Date(), firstName: "Test", lastName: "Name 3"), genre: .adventure, tags: nil, text: "Test text 3", viewCount: 0, likeCount: 0, dislikeCount: 0, commentCount: 0, comments: nil),
                    StoryModel(id: "004", dateCreated: Date(), dateUpdated: Date(), title: "Test Title 4", description: "Test Description 4", author: UserModel(id: "004", dateCreated: Date(), dateUpdated: Date(), firstName: "Test", lastName: "Name 4"), genre: .adventure, tags: nil, text: "Test text 4", viewCount: 0, likeCount: 0, dislikeCount: 0, commentCount: 0, comments: nil),
                    StoryModel(id: "000", dateCreated: Date(), dateUpdated: Date(), title: "Test Title 0", description: "Test Description 0", author: UserModel(id: "000", dateCreated: Date(), dateUpdated: Date(), firstName: "Test", lastName: "Name 0"), genre: .dystopian, tags: nil, text: "Test text 0", viewCount: 0, likeCount: 0, dislikeCount: 0, commentCount: 0, comments: nil),
                    StoryModel(id: "001", dateCreated: Date(), dateUpdated: Date(), title: "Test Title 1", description: "Test Description 0", author: UserModel(id: "001", dateCreated: Date(), dateUpdated: Date(), firstName: "Test", lastName: "Name 1"), genre: .dystopian, tags: nil, text: "Test text 1", viewCount: 0, likeCount: 0, dislikeCount: 0, commentCount: 0, comments: nil),
                    StoryModel(id: "002", dateCreated: Date(), dateUpdated: Date(), title: "Test Title 2", description: "Test Description 2", author: UserModel(id: "002", dateCreated: Date(), dateUpdated: Date(), firstName: "Test", lastName: "Name 2"), genre: .dystopian, tags: nil, text: "Test text 2", viewCount: 0, likeCount: 0, dislikeCount: 0, commentCount: 0, comments: nil),
                    StoryModel(id: "003", dateCreated: Date(), dateUpdated: Date(), title: "Test Title 3", description: "Test Description 3", author: UserModel(id: "003", dateCreated: Date(), dateUpdated: Date(), firstName: "Test", lastName: "Name 3"), genre: .dystopian, tags: nil, text: "Test text 3", viewCount: 0, likeCount: 0, dislikeCount: 0, commentCount: 0, comments: nil),
                    StoryModel(id: "004", dateCreated: Date(), dateUpdated: Date(), title: "Test Title 4", description: "Test Description 4", author: UserModel(id: "004", dateCreated: Date(), dateUpdated: Date(), firstName: "Test", lastName: "Name 4"), genre: .dystopian, tags: nil, text: "Test text 4", viewCount: 0, likeCount: 0, dislikeCount: 0, commentCount: 0, comments: nil),
                    StoryModel(id: "000", dateCreated: Date(), dateUpdated: Date(), title: "Test Title 0", description: "Test Description 0", author: UserModel(id: "000", dateCreated: Date(), dateUpdated: Date(), firstName: "Test", lastName: "Name 0"), genre: .fantasy, tags: nil, text: "Test text 0", viewCount: 0, likeCount: 0, dislikeCount: 0, commentCount: 0, comments: nil),
                    StoryModel(id: "001", dateCreated: Date(), dateUpdated: Date(), title: "Test Title 1", description: "Test Description 0", author: UserModel(id: "001", dateCreated: Date(), dateUpdated: Date(), firstName: "Test", lastName: "Name 1"), genre: .fantasy, tags: nil, text: "Test text 1", viewCount: 0, likeCount: 0, dislikeCount: 0, commentCount: 0, comments: nil),
                    StoryModel(id: "002", dateCreated: Date(), dateUpdated: Date(), title: "Test Title 2", description: "Test Description 2", author: UserModel(id: "002", dateCreated: Date(), dateUpdated: Date(), firstName: "Test", lastName: "Name 2"), genre: .fantasy, tags: nil, text: "Test text 2", viewCount: 0, likeCount: 0, dislikeCount: 0, commentCount: 0, comments: nil),
                    StoryModel(id: "003", dateCreated: Date(), dateUpdated: Date(), title: "Test Title 3", description: "Test Description 3", author: UserModel(id: "003", dateCreated: Date(), dateUpdated: Date(), firstName: "Test", lastName: "Name 3"), genre: .fantasy, tags: nil, text: "Test text 3", viewCount: 0, likeCount: 0, dislikeCount: 0, commentCount: 0, comments: nil),
                    StoryModel(id: "004", dateCreated: Date(), dateUpdated: Date(), title: "Test Title 4", description: "Test Description 4", author: UserModel(id: "004", dateCreated: Date(), dateUpdated: Date(), firstName: "Test", lastName: "Name 4"), genre: .fantasy, tags: nil, text: "Test text 4", viewCount: 0, likeCount: 0, dislikeCount: 0, commentCount: 0, comments: nil)
                ],
            ]
            
            completion()
        }
    }
    
    func load(completion: (() -> ())?) {
        self.sections?.removeAll()
        self.storyModels?.removeAll()
        self.collectionView.reloadData()
        
        self.activityIndicatorView.startAnimating()
        self.loadData {
            self.activityIndicatorView.stopAnimating()
            self.collectionView.reloadData()
            completion?()
        }
    }
    
    @objc private func handleRefreshControl(_ sender: UIRefreshControl) {
        self.loadData {
            self.collectionView.reloadData()
            sender.endRefreshing()
        }
    }
    
    @objc private func handleComposeButton(_ sender: UIButton) {
        
    }
}
