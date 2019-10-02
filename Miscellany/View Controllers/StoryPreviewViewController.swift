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
            let leftMargin = self.view.layoutMargins.left + (sizeClassConstant / 2)
            let rightMargin = self.view.layoutMargins.right + (sizeClassConstant / 2)
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(width), heightDimension: .fractionalHeight(1.0))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
            group.interItemSpacing = .fixed(10)
             
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPaging
            section.interGroupSpacing = 10
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: leftMargin, bottom: 0, trailing: rightMargin)
            
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
    init(firstIndex: Int, storyModels: [StoryModel], imageService: ImageService) {
        self.firstIndex = firstIndex
        self.storyModels = storyModels
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.layoutIfNeeded()
    }
}

// MARK: Properties
extension StoryPreviewViewController {
    override func configureProperties() {
        super.configureProperties()
        
        self.extendedLayoutIncludesOpaqueBars = true
        self.edgesForExtendedLayout = [.top, .bottom]
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
        
        NSLayoutConstraint.deactivate(self.collectionViewConstraints)
        
        self.collectionViewConstraints = [
            self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(self.collectionViewConstraints)
    }
}

// MARK: Navigation
extension StoryPreviewViewController {
    override func configureNavigation(_ animated: Bool) {
        super.configureNavigation(animated)
        
        self.navigationItem.title = "Preview"
        
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
        let storyViewController = StoryViewController(storyModel: storyModel, textSettings: SettingsManager.shared.textSettings)
        storyViewController.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(storyViewController, animated: true)
    }
}
