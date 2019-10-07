//
//  StoryPreviewViewController.swift
//  Miscellany
//
//  Created by Theodore Gallao on 9/22/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

class StoryPreviewViewController: BaseViewController {
    // MARK: Data Members
    private let userService: UserService
    private let imageService: ImageService
    
    private var firstIndex: Int
    private var firstTime = true
    
    private(set) var storyModels: [StoryModel]
    
    private lazy var collectionViewCompositionalLayout: UICollectionViewCompositionalLayout = {
        return UICollectionViewCompositionalLayout { (sectionIndex, layouEnvironment) -> NSCollectionLayoutSection? in
            let marginedWidth = self.view.layoutMarginsGuide.layoutFrame.width
            let isCompact = self.traitCollection.horizontalSizeClass == .compact
            let sizeClassConstant: CGFloat = isCompact ? 0 : marginedWidth * 0.2
            let width = marginedWidth - sizeClassConstant
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(width), heightDimension: .fractionalHeight(1.0))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
             
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPagingCentered
            section.interGroupSpacing = 4
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            
            return section
        }
    }()
    
    // MARK: Views
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.collectionViewCompositionalLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.clear
        collectionView.allowsSelection = false
        collectionView.allowsMultipleSelection = false
        collectionView.isPagingEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(StoryPreviewCollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.Id.preview.rawValue)
        
        return collectionView
    }()
    
    // Constraint Variables
    internal var collectionViewConstraints = [NSLayoutConstraint]()
    
    // MARK: Initializers
    init(firstIndex: Int, storyModels: [StoryModel], userService: UserService, imageService: ImageService) {
        self.firstIndex = firstIndex
        self.storyModels = storyModels
        self.userService = userService
        self.imageService = imageService
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(firstIndex: Int, storyModels: [StoryModel]) {
        self.firstTime = true
        self.firstIndex = firstIndex
        self.storyModels = storyModels
        
        self.collectionView.reloadData()
    }
}

// MARK: Properties
extension StoryPreviewViewController {
    override func configureProperties() {
        super.configureProperties()
        
        // Extend layout past navigation and tab bars
        self.extendedLayoutIncludesOpaqueBars = true
        
    }
}

// MARK: View, Layout & Constraints
extension StoryPreviewViewController {
    override func configureViews() {
        super.configureViews()
        
        self.view.backgroundColor = UIColor(named: "Empty")
        
        self.view.addSubview(self.collectionView)
    }
    
    override func configureLayout() {
        super.configureLayout()
        
        self.collectionViewConstraints = [
            self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ]
    }
    
    override func deactivateConstraints() {
        super.deactivateConstraints()
        
        NSLayoutConstraint.deactivate(self.collectionViewConstraints)
    }
    
    override func activateConstraints() {
        super.activateConstraints()
        
        NSLayoutConstraint.activate(self.collectionViewConstraints)
    }
    
    override func configureLayoutForCompactSizeClass() {
        super.configureLayoutForCompactSizeClass()
        
        self.viewRespectsSystemMinimumLayoutMargins = true
        self.view.directionalLayoutMargins.leading = 8
        self.view.directionalLayoutMargins.trailing = 8
        
        if let navigationController = self.navigationController {
            navigationController.viewRespectsSystemMinimumLayoutMargins = true
            navigationController.view.directionalLayoutMargins.leading = 8
            navigationController.view.directionalLayoutMargins.trailing = 8
            navigationController.navigationBar.directionalLayoutMargins.leading = 8
            navigationController.navigationBar.directionalLayoutMargins.trailing = 8
        }
    }
    
    override func configureLayoutForRegularSizeClass() {
        super.configureLayoutForRegularSizeClass()
        
        self.viewRespectsSystemMinimumLayoutMargins = false
        self.view.directionalLayoutMargins.leading = 64
        self.view.directionalLayoutMargins.trailing = 64
        
        if let navigationController = self.navigationController {
            navigationController.viewRespectsSystemMinimumLayoutMargins = true
            navigationController.view.directionalLayoutMargins.leading = 64
            navigationController.view.directionalLayoutMargins.trailing = 64
            navigationController.navigationBar.directionalLayoutMargins.leading = 64
            navigationController.navigationBar.directionalLayoutMargins.trailing = 64
        }
    }
}

extension StoryPreviewViewController {
    override func configureNavigation(_ animated: Bool) {
        self.navigationItem.largeTitleDisplayMode = .never
        
        if let navigationController = self.navigationController {
            navigationController.setNavigationBarHidden(false, animated: animated)
            navigationController.setToolbarHidden(true, animated: animated)
            navigationController.hidesBarsOnSwipe = false
            navigationController.hidesBarsOnTap = false
        }
    }
}

// MARK: Collection View Data Source
extension StoryPreviewViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.storyModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell.Id.preview.rawValue, for: indexPath) as! StoryPreviewCollectionViewCell
        cell.delegate = self

        if let storyModel = self.storyModels[optional: indexPath.row] {
            cell.set(storyModel, imageService: self.imageService)
        }
        
        return cell
    }
}

// MARK: Collection View Delegate
extension StoryPreviewViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if self.firstTime {
            self.firstTime = false

            self.collectionView.scrollToItem(at: IndexPath(item: self.firstIndex, section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: false)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}

// MARK: Story Preview Collection View Cell Delegate
extension StoryPreviewViewController: StoryPreviewCollectionViewCellDelegate {
    func storyPreviewCollectionViewCell(_ storyPreviewCollectionViewCell: StoryPreviewCollectionViewCell, didTapRead sender: UIButton) {
        guard
            let indexPath = self.collectionView.indexPath(for: storyPreviewCollectionViewCell),
            let storyModel = self.storyModels[optional: indexPath.row] else
        {
            print("ERROR: Unable to find StoryModel")
            return
        }
        let storyViewController = StoryViewController(storyModel: storyModel, textSettings: SettingsManager.shared.textSettings, userService: self.userService, storyService: .shared)
        storyViewController.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(storyViewController, animated: true)
    }
    
    func storyPreviewCollectionViewCell(_ storyPreviewCollectionViewCell: StoryPreviewCollectionViewCell, didTapReadingList sender: UIButton) {
        if let currentUser = self.userService.currentUser {
            print(currentUser.id)
        } else {
            self.userService.presentSignIn(in: self)
        }
    }
    
    func storyPreviewCollectionViewCell(_ storyPreviewCollectionViewCell: StoryPreviewCollectionViewCell, didTapLibrary sender: UIButton) {
        if let currentUser = self.userService.currentUser {
            print(currentUser.id)
        } else {
            self.userService.presentSignIn(in: self)
        }
    }
}
