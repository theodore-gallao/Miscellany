//
//  HomeViewController.swift
//  Miscellany
//
//  Created by Theodore Gallao on 6/11/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

typealias SectionProvider = (UserModel) -> [SectionModel]

// MARK: HomeViewController
final class HomeViewController: SectionCollectionViewController {
    // Services
    private let userService: UserService
    private let storyService: StoryService
    private let genreService: GenreService
    private let imageService: ImageService
    
    // Managers
    private let settingsManager: SettingsManager
    
    // Content Data
    private var sections: [SectionModel] = []
    private var items: [SectionModel: [Itemable]] = [:]
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        activityIndicator.tintColor = UIColor(named: "Text")
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        return activityIndicator
    }()
    
    // Constraint Variables
    internal var activityIndicatorViewConstraints = [NSLayoutConstraint]()
    
    // MARK: Initializers
    init(
        userService: UserService = .shared,
        storyService: StoryService = .shared,
        imageService: ImageService = .shared,
        genreService: GenreService = .shared,
        settingsManager: SettingsManager = .shared
    ) {
        self.userService = userService
        self.storyService = storyService
        self.imageService = imageService
        self.genreService = genreService
        self.settingsManager = settingsManager
        
        super.init(nibName: nil, bundle: nil)
        
        self.delegate = self
        self.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { _ in
            self.collectionView.collectionViewLayout.invalidateLayout()
            self.configureLayout()
            self.view.layoutIfNeeded()
        }, completion: nil)
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
        
        self.view.addSubview(self.activityIndicatorView)
    }
    
    override func configureLayout() {
        super.configureLayout()
        
        self.navigationController?.navigationBar.directionalLayoutMargins = self.display.directionalLayoutMargins
    }
    
    override func deactivateConstraints() {
        super.deactivateConstraints()
        
        NSLayoutConstraint.deactivate(self.activityIndicatorViewConstraints)
    }
    
    override func activateConstraints() {
        super.activateConstraints()
        
        NSLayoutConstraint.activate(self.activityIndicatorViewConstraints)
    }
    
    override func configureLayoutForCompactSizeClass() {
        super.configureLayoutForCompactSizeClass()
        
        self.activityIndicatorViewConstraints = [
            self.activityIndicatorView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            self.activityIndicatorView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0)
        ]
    }
    
    override func configureLayoutForRegularSizeClass() {
        super.configureLayoutForRegularSizeClass()
        
        self.activityIndicatorViewConstraints = [
            self.activityIndicatorView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            self.activityIndicatorView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0)
        ]
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
            navigationController.setToolbarHidden(
                true,
                animated: animated)
        }
    }
}

// MARK: Section Collection View
extension HomeViewController: SectionCollectionViewControllerDelegate, SectionCollectionViewControllerDataSource {
    func numberOfSections(in sectionCollectionViewController: SectionCollectionViewController) -> Int {
        return self.sections.count
    }
    
    func sectionCollectionViewController(_ sectionCollectionViewController: SectionCollectionViewController, sectionAtIndex index: Int) -> SectionModel {
        return self.sections[index]
    }
    
    func sectionCollectionViewController(_ sectionCollectionViewController: SectionCollectionViewController, numberOfItemsInSection section: SectionModel) -> Int {
        return 25
    }
    
    func sectionCollectionViewController(_ sectionCollectionViewController: SectionCollectionViewController, itemAtIndex index: Int, fromSection section: SectionModel) -> Itemable {
        let item = BaseStoryModel(id: "000", title: "Test Title", author: BaseUserModel(id: "000", firstName: "First", lastName: "Last", subscriberCount: 0))
        
        return item
    }
    
    func sectionCollectionViewController(_ sectionCollectionViewController: SectionCollectionViewController, groupTitleAtIndex index: Int, fromSection section: SectionModel) -> String? {
        
        return "GROUP TITLE"
    }
}

// MARK: Selectors
extension HomeViewController {
    private func loadData(_ completion: @escaping() -> ()) {
        if self.userService.currentUser?.isAnonymous ?? true {
            self.sections = [
                SectionModel(
                    properties: SectionProperties(
                        title: nil,
                        description: nil,
                        actionTitle: nil,
                        actionImage: nil,
                        orthagonalScrollingBehavior: .groupPaging,
                        indicatorStyle: .none),
                    itemProperties: ItemProperties(
                        configuration: .large,
                        itemCount: DisplayProperty<Int>(
                            compact: 1,
                            standard: 1,
                            large: 1,
                            extraLarge: 1),
                        heightConstant: DisplayProperty<CGFloat>(
                            compact: 74,
                            standard: 74,
                            large: 74,
                            extraLarge: 74),
                        imageAspectRatio: 6 / 9,
                        imageCornerRadius: DisplayProperty<CGFloat>(
                            compact: 4,
                            standard: 4,
                            large: 4,
                            extraLarge: 4),
                        shouldIgnoreImageAspectRatioForGroupHeight: false,
                        textAlignment: .natural,
                        headlineAlpha: 1,
                        headlineTextColor: UIColor(named: "Primary"),
                        headlineFont: .systemFont(ofSize: 12, weight: .bold),
                        titleFont: .systemFont(ofSize: 22, weight: .bold)),
                    groupProperties: GroupProperties(
                        isHeaderEnabled: false,
                        columnCount: DisplayProperty<CGFloat>(
                            compact: 1,
                            standard: 1,
                            large: 1 + (1 / 3),
                            extraLarge: 2),
                        layoutDirection: .horizontal)),
                SectionModel(
                    properties: SectionProperties(
                        title: "New & Trending",
                        description: "Fresh stories on the rise.",
                        actionTitle: nil,
                        actionImage: nil,
                        orthagonalScrollingBehavior: .continuousGroupLeadingBoundary,
                        indicatorStyle: .more),
                    itemProperties: ItemProperties(
                        configuration: .standard,
                        itemCount: DisplayProperty<Int>(
                            compact: 1,
                            standard: 1,
                            large: 2,
                            extraLarge: 2),
                        heightConstant: DisplayProperty<CGFloat>(
                            compact: 44,
                            standard: 44,
                            large: 44,
                            extraLarge: 44),
                        imageAspectRatio: 9 / 6,
                        imageCornerRadius: DisplayProperty<CGFloat>(
                            compact: 4,
                            standard: 4,
                            large: 4,
                            extraLarge: 4),
                        shouldIgnoreImageAspectRatioForGroupHeight: false,
                        textAlignment: .natural,
                        headlineAlpha: 0,
                        headlineTextColor: nil,
                        headlineFont: .systemFont(ofSize: 12, weight: .bold),
                        titleFont: .systemFont(ofSize: 16, weight: .bold)),
                    groupProperties: GroupProperties(
                        isHeaderEnabled: false,
                        columnCount: DisplayProperty<CGFloat>(
                            compact: 2,
                            standard: 3,
                            large: 4,
                            extraLarge: 6),
                        layoutDirection: .vertical)),
                SectionModel(
                    properties: SectionProperties(
                        title: "Top Charts",
                        description: "The very best.",
                        actionTitle: nil,
                        actionImage: nil,
                        orthagonalScrollingBehavior: .groupPaging,
                        indicatorStyle: .more),
                    itemProperties: ItemProperties(
                        configuration: .ranked,
                        itemCount: DisplayProperty(5),
                        heightConstant: DisplayProperty(64),
                        imageAspectRatio: 9 / 6,
                        imageCornerRadius: DisplayProperty(4),
                        shouldIgnoreImageAspectRatioForGroupHeight: true,
                        textAlignment: .natural,
                        headlineAlpha: 1,
                        headlineTextColor: UIColor(named: "Text"),
                        headlineFont: .systemFont(ofSize: 22, weight: .bold),
                        titleFont: .systemFont(ofSize: 16, weight: .bold)),
                    groupProperties: GroupProperties(
                        isHeaderEnabled: true,
                        columnCount: DisplayProperty(
                            compact: 1,
                            standard: 1.5,
                            large: 2,
                            extraLarge: 2.5),
                        layoutDirection: .vertical)),
                SectionModel(
                    properties: SectionProperties(
                        title: "Our Favorites",
                        description: "Stories that we love right now.",
                        actionTitle: nil,
                        actionImage: nil,
                        orthagonalScrollingBehavior: .continuousGroupLeadingBoundary,
                        indicatorStyle: .more),
                    itemProperties: ItemProperties(
                        configuration: .standard,
                        itemCount: DisplayProperty<Int>(
                            compact: 1,
                            standard: 1,
                            large: 2,
                            extraLarge: 2),
                        heightConstant: DisplayProperty<CGFloat>(
                            compact: 44,
                            standard: 44,
                            large: 44,
                            extraLarge: 44),
                        imageAspectRatio: 9 / 6,
                        imageCornerRadius: DisplayProperty<CGFloat>(
                            compact: 4,
                            standard: 4,
                            large: 4,
                            extraLarge: 4),
                        shouldIgnoreImageAspectRatioForGroupHeight: false,
                        textAlignment: .natural,
                        headlineAlpha: 0,
                        headlineTextColor: nil,
                        headlineFont: .systemFont(ofSize: 12, weight: .bold),
                        titleFont: .systemFont(ofSize: 16, weight: .bold)),
                    groupProperties: GroupProperties(
                        isHeaderEnabled: false,
                        columnCount: DisplayProperty<CGFloat>(
                            compact: 2,
                            standard: 3,
                            large: 4,
                            extraLarge: 6),
                        layoutDirection: .vertical)),
                SectionModel(
                    properties: SectionProperties(
                        title: "Popular Authors",
                        description: "See what they've written.",
                        actionTitle: nil,
                        actionImage: nil,
                        orthagonalScrollingBehavior: .groupPaging,
                        indicatorStyle: .more),
                    itemProperties: ItemProperties(
                        configuration: .list,
                        itemCount: DisplayProperty<Int>(
                            compact: 3,
                            standard: 3,
                            large: 3,
                            extraLarge: 3),
                        heightConstant: DisplayProperty<CGFloat>(50),
                        spacingConstant: DisplayProperty(5),
                        imageAspectRatio: 1,
                        imageCornerRadius: DisplayProperty<CGFloat>(25),
                        shouldIgnoreImageAspectRatioForGroupHeight: true,
                        textAlignment: .natural,
                        headlineAlpha: 0,
                        headlineTextColor: nil,
                        headlineFont: .systemFont(ofSize: 22, weight: .bold),
                        titleFont: .systemFont(ofSize: 16, weight: .bold)),
                    groupProperties: GroupProperties(
                        isHeaderEnabled: false,
                        columnCount: DisplayProperty<CGFloat>(
                            compact: 1,
                            standard: 1.5,
                            large: 2,
                            extraLarge: 2.5),
                        layoutDirection: .vertical)),
                SectionModel(
                    properties: SectionProperties(
                        title: "Popular Tags",
                        description: "People like these kinds of stories lately.",
                        actionTitle: nil,
                        actionImage: nil,
                        orthagonalScrollingBehavior: .groupPaging,
                        indicatorStyle: .more),
                    itemProperties: ItemProperties(
                        configuration: .list,
                        itemCount: DisplayProperty<Int>(
                            compact: 3,
                            standard: 3,
                            large: 3,
                            extraLarge: 3),
                        heightConstant: DisplayProperty<CGFloat>(
                            compact: 56,
                            standard: 58,
                            large: 60,
                            extraLarge: 62),
                        spacingConstant: DisplayProperty(5),
                        imageAspectRatio: 1,
                        imageCornerRadius: DisplayProperty<CGFloat>(
                            compact: 56 / 2,
                            standard: 58 / 2,
                            large: 60 / 2,
                            extraLarge: 62 / 2),
                        shouldIgnoreImageAspectRatioForGroupHeight: true,
                        textAlignment: .natural,
                        headlineAlpha: 0,
                        headlineTextColor: nil,
                        headlineFont: .systemFont(ofSize: 22, weight: .bold),
                        titleFont: .systemFont(ofSize: 16, weight: .bold)),
                    groupProperties: GroupProperties(
                        isHeaderEnabled: false,
                        columnCount: DisplayProperty<CGFloat>(
                            compact: 1,
                            standard: 1.5,
                            large: 2,
                            extraLarge: 2.5),
                        layoutDirection: .vertical)),
                SectionModel(
                    properties: SectionProperties(
                        title: "More To Explore",
                        description: "See what else Miscellany has to offer.",
                        actionTitle: nil,
                        actionImage: nil,
                        orthagonalScrollingBehavior: .groupPaging,
                        indicatorStyle: .none),
                    itemProperties: ItemProperties(
                        configuration: .standard,
                        itemCount: DisplayProperty<Int>(
                            compact: 1,
                            standard: 1,
                            large: 1,
                            extraLarge: 1),
                        heightConstant: DisplayProperty<CGFloat>(
                            compact: 50,
                            standard: 50,
                            large: 50,
                            extraLarge: 50),
                        imageAspectRatio: 6 / 9,
                        imageCornerRadius: DisplayProperty<CGFloat>(
                            compact: 4,
                            standard: 4,
                            large: 4,
                            extraLarge: 4),
                        shouldIgnoreImageAspectRatioForGroupHeight: false,
                        textAlignment: .natural,
                        headlineAlpha: 0,
                        headlineTextColor: nil,
                        headlineFont: .systemFont(ofSize: 12, weight: .bold),
                        titleFont: .systemFont(ofSize: 22, weight: .bold)),
                    groupProperties: GroupProperties(
                        isHeaderEnabled: false,
                        columnCount: DisplayProperty<CGFloat>(
                            compact: 1,
                            standard: 1 + (1 / 3),
                            large: 2,
                            extraLarge: 2 + (1 / 3)),
                        layoutDirection: .vertical))
            ]
        } else {
            self.sections = [
                
            ]
        }
        
        completion()
    }
    
    func load(completion: (() -> ())?) {
        self.sections.removeAll()
        self.items.removeAll()
        self.collectionView.reloadData()

        self.activityIndicatorView.startAnimating()
        self.loadData {
            self.activityIndicatorView.stopAnimating()
            self.collectionView.reloadData()
            completion?()
        }
    }
}
