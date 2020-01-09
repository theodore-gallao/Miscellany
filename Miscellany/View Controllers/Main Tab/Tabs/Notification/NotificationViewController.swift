//
//  InboxViewController.swift
//  Miscellany
//
//  Created by Theodore Gallao on 10/8/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

// MARK: Section
extension NotificationViewController {
    enum Section {
        case all
    }
}

// MARK: Item and Cells
extension NotificationViewController {
    struct Item: Hashable {
        enum DataType {
            case notification
        }
        
        var section: Section
        var type: DataType
        var targetId: String
    }
    
    enum CellReuseIdentifier: String {
        case notification = "__NOTIFICATION_COLLECTION_VIEW_CELL_ID__"
    }
}
class NotificationViewController: BaseViewController {
    // MARK: Flags
    private(set) var isViewOptionsActive: Bool = false {
        didSet {
            let configuration = UIImage.SymbolConfiguration(weight: .medium)
            let image = UIImage(
                systemName: self.isViewOptionsActive ?
                    "line.horizontal.3.decrease.circle.fill" : "line.horizontal.3.decrease.circle",
                withConfiguration: configuration)
            self.viewOptionsBarButtonItem.image = image
        }
    }
    
    private lazy var dataProvider: NotificationDataProvider = {
        let dataProvider = NotificationDataProvider()
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
        
        collectionView.register(NotificationCollectionViewCell.self, forCellWithReuseIdentifier: CellReuseIdentifier.notification.rawValue)
        
        return collectionView
    }()
    
    // MARK: Collection View Layout
    private lazy var collectionViewLayout: UICollectionViewCompositionalLayout = {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .vertical
        configuration.interSectionSpacing = self.displayMode.spacing + 20
        
        return UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let marginedWidth = self.view.layoutMarginsGuide.layoutFrame.width
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: self.traitCollection.horizontalSizeClass == .compact ? 1 : 2)
            group.interItemSpacing = .fixed(self.displayMode.spacing)
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = self.displayMode.spacing
            section.contentInsets = self.displayMode.directionalLayoutMargins
            section.orthogonalScrollingBehavior = .none
            
            return section
        }, configuration: configuration)
    }()
    
    // MARK: Collection View Data Source
    private lazy var dataSource: UICollectionViewDiffableDataSource<Section, Item> = {
        let collectionView = self.collectionView
        
        // MARK: Cell
        let dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView)
        { (collectionView, indexPath, item) -> UICollectionViewCell? in
            guard
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellReuseIdentifier.notification.rawValue, for: indexPath) as? NotificationCollectionViewCell,
                let notification = self.dataProvider.notifications[item.targetId]
            else { fatalError("ERROR: Unable to make cell") }
            
            cell.set(notification: notification)
            return cell
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
    
    private lazy var viewOptionsBarButtonItem: UIBarButtonItem = {
        let configuration = UIImage.SymbolConfiguration(weight: .medium)
        let image = UIImage(systemName: "line.horizontal.3.decrease.circle", withConfiguration: configuration)
        
        let barButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(self.handleViewOptionsBarButtonItem(_:)))
        
        return barButtonItem
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
extension NotificationViewController {
    override func configureProperties() {
        super.configureProperties()
    }
}

// MARK: Additional
extension NotificationViewController {
    override func configureAdditional() {
        super.configureAdditional()
    }
}

// MARK: Views, Layout & Constraints
extension NotificationViewController {
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
extension NotificationViewController {
    override func configureNavigation(_ animated: Bool) {
        super.configureNavigation(animated)
        
        self.navigationItem.title = "Notifications"
        self.navigationItem.setRightBarButton(self.viewOptionsBarButtonItem, animated: animated)
        
        if let navigationController = self.navigationController {
            navigationController.hidesBarsOnTap = false
            navigationController.hidesBarsOnSwipe = false
            navigationController.navigationBar.tintColor = UIColor(named: "Primary")
            navigationController.setToolbarHidden(true, animated: animated)
            navigationController.setNavigationBarHidden(false, animated: animated)
        }
    }
}

// MARK: Collection View - Delegate
extension NotificationViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard
            let section = self.dataProvider.sections[optional: indexPath.section],
            let items = self.dataProvider.items(for: section),
            let item = items[optional: indexPath.item],
            let notification = self.dataProvider.notifications[item.targetId] else
        {
            print("Nope - ", indexPath)
            return
        }
        
        let viewController: UIViewController
        // Depending on the notification target type, push the appropriate view controller, passing the target id.
        switch notification.targetType {
        case .article:
            viewController = UIViewController()
        case .comment:
            viewController = UIViewController()
        case .story:
            let baseStory = BaseStory(id: notification.targetId, title: "", author: BaseUser(id: "", firstName: "", lastName: "", username: ""))
            let storyPreviewPageViewController = StoryPreviewPageViewController(stories: [baseStory], firstIndex: 0)
            storyPreviewPageViewController.hidesBottomBarWhenPushed = true
            
            viewController = storyPreviewPageViewController
        case .user:
            viewController = UIViewController()
        }
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: Notification Data Provider
extension NotificationViewController: NotificationDataProviderDelegate {
    func notificationDataProviderDidUpdate(_ notificationDataProvider: NotificationDataProvider) {
        self.updateCollectionView(animated: true)
    }
}

// MARK: Selectors
extension NotificationViewController {
    func updateCollectionView(animated: Bool) {
        DispatchQueue(label: "Collection View Updates", qos: .utility).async { [weak self] in
            guard let sections = self?.dataProvider.sections else { return }
            
            var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
            snapshot.appendSections(sections)
            
            sections.forEach { [weak self] (section) in
                guard let items = self?.dataProvider.items(for: section) else { return }
                
                snapshot.appendItems(items, toSection: section)
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.activityIndicatorView.stopAnimating()
                self?.dataSource.apply(snapshot, animatingDifferences: animated)
            }
        }
    }
    
    @objc private func handleViewOptionsBarButtonItem(_ sender: UIBarButtonItem) {
        // TODO: Make a view pop up to handle view options, then set isViewOptionsActive appropriately. For now, just toggle.
        self.isViewOptionsActive = !self.isViewOptionsActive
    }
}
