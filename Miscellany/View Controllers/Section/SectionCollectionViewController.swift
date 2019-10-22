//
//  SectionCollectionView.swift
//  Miscellany
//
//  Created by Theodore Gallao on 10/15/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

// MARK: Delegate
/// Provides methods that are called when specific actions related to the `SectionView` occurs
protocol SectionCollectionViewControllerDelegate: class {
    func sectionCollectionViewController(
        _ sectionCollectionViewController: SectionCollectionViewController,
        didSelectSectionAt index: Int
    )
    
    func sectionCollectionViewController(
        _ sectionCollectionViewController: SectionCollectionViewController,
        didSelectItemAt index: Int,
        from section: SectionModel
    )
}

extension SectionCollectionViewControllerDelegate {
    func sectionCollectionViewController(
        _ sectionCollectionViewController: SectionCollectionViewController,
        didSelectSectionAt index: Int
    ) {}
    
    func sectionCollectionViewController(
        _ sectionCollectionViewController: SectionCollectionViewController,
        didSelectItemAt index: Int,
        from section: SectionModel
    ) {}
}

// MARK: Data Source
/// Objects that conform to `SectionCollectionViewDataSource` must implement the methods necessary to provide data
protocol SectionCollectionViewControllerDataSource: class {
    func numberOfSections(
        in sectionCollectionViewController: SectionCollectionViewController
    ) -> Int
    
    func sectionCollectionViewController(
        _ sectionCollectionViewController: SectionCollectionViewController,
        sectionAtIndex index: Int
    ) -> SectionModel
    
    func sectionCollectionViewController(
        _ sectionCollectionViewController: SectionCollectionViewController,
        numberOfItemsInSection section: SectionModel
    ) -> Int
    
    func sectionCollectionViewController(
        _ sectionCollectionViewController: SectionCollectionViewController,
        itemAtIndex index: Int,
        fromSection section: SectionModel
    ) -> Itemable
    
    func sectionCollectionViewController(
        _ sectionCollectionViewController: SectionCollectionViewController,
        groupTitleAtIndex index: Int,
        fromSection section: SectionModel
    ) -> String?
}

// MARK: Declaration
class SectionCollectionViewController: BaseViewController {
    weak var delegate: SectionCollectionViewControllerDelegate?
    weak var dataSource: SectionCollectionViewControllerDataSource?
    
    private let configuration: UICollectionViewCompositionalLayoutConfiguration = {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .vertical
        configuration.interSectionSpacing = 30
        
        return configuration
    }()
    
    private lazy var sectionProvider: UICollectionViewCompositionalLayoutSectionProvider = {
        return { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            guard
                let section = self.dataSource?.sectionCollectionViewController(
                    self,
                    sectionAtIndex: sectionIndex)
                else { return nil }
            
            let item = self.makeCollectionLayoutItem(
                for: section,
                in: layoutEnvironment)
            
            let group = self.makeCollectionLayoutGroup(
                with: item,
                for: section,
                in: layoutEnvironment)
            
            return self.makeCollectionLayoutSection(
                with: group,
                for: section,
                in: layoutEnvironment)
        }
    }()
    
    private lazy var collectionViewLayout: UICollectionViewCompositionalLayout = {
        return UICollectionViewCompositionalLayout(
            sectionProvider: self.sectionProvider,
            configuration: self.configuration)
    }()
    
    private(set) lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: self.collectionViewLayout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = true
        collectionView.alwaysBounceVertical = true
        collectionView.isScrollEnabled = true
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(
            SectionItemCollectionViewCell.self,
            forCellWithReuseIdentifier: self.cellId)
        
        collectionView.register(
            SectionHeaderCollectionReusableView.self,
            forSupplementaryViewOfKind: self.boundarySupplementaryItemKind,
            withReuseIdentifier: self.boundarySupplementaryItemId)
        collectionView.register(
            GroupHeaderCollectionReusableView.self,
            forSupplementaryViewOfKind: self.supplementaryItemKind,
            withReuseIdentifier: self.supplementaryItemId)
        
        return collectionView
    }()
    
    private let cellId = "__CELL_ID__"
    private let boundarySupplementaryItemId = "__BOUNDARY_SUPPLEMENTARY_ITEM_ID__"
    private let supplementaryItemId = "__SUPPLEMENTARY_ITEM_ID__"
    
    private let boundarySupplementaryItemKind = "__BOUNDARY_SUPPLEMENTARY_ITEM_KIND__"
    private let supplementaryItemKind = "__SUPPLEMENTARY_ITEM_KIND__"
    
    
    var collectionViewConstraints = [NSLayoutConstraint]()
}

// MARK: Views, Layout & Constraints
extension SectionCollectionViewController {
    override func configureViews() {
        super.configureViews()
        
        self.view.addSubview(self.collectionView)
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
        
        self.collectionViewConstraints = [
            self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ]
    }
    
    override func configureLayoutForRegularSizeClass() {
        super.configureLayoutForRegularSizeClass()
        
        self.collectionViewConstraints = [
            self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ]
    }
}

// MARK: Display Mode
extension SectionCollectionViewController {
    var display: DisplayModel {
        return DisplayModel(width: self.view.bounds.width)
    }
}


// MARK: Collection Layout
extension SectionCollectionViewController {
    func invalidateLayout() {
        self.collectionViewLayout.invalidateLayout()
    }
    
    private func makeCollectionLayoutItem(
        for section: SectionModel,
        in layoutEnvironment: NSCollectionLayoutEnvironment
    ) -> NSCollectionLayoutItem {
        let widthDimension: NSCollectionLayoutDimension = .fractionalWidth(1.0)
        let heightDimension: NSCollectionLayoutDimension = .fractionalHeight(1.0)
        let itemSize = NSCollectionLayoutSize(
            widthDimension: widthDimension,
            heightDimension: heightDimension)
        
        return NSCollectionLayoutItem(layoutSize: itemSize)
    }
    
    private func makeCollectionLayoutGroup(
        with item: NSCollectionLayoutItem,
        for section: SectionModel,
        in layoutEnvironment: NSCollectionLayoutEnvironment
    ) -> NSCollectionLayoutGroup {
        let display = self.display
        let itemCount = section.itemProperties.itemCount.value(for: display.displayMode)
        let groupHeaderConstant: CGFloat = section.groupProperties.isHeaderEnabled ? 30 : 0
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(display.groupWidth(for: section)),
            heightDimension: .absolute(display.groupHeight(for: section) + groupHeaderConstant))
        let group = section.groupProperties.layoutDirection == .vertical ?
            NSCollectionLayoutGroup.vertical(
                layoutSize: groupSize,
                subitem: item,
                count: itemCount) :
            NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitem: item,
                count: itemCount)
        group.interItemSpacing = .fixed(display.spacing + section.itemProperties.spacingConstant.value(for: display.displayMode))
        group.supplementaryItems = self.makeCollectionLayoutSupplementaryItems(
            for: section,
            in: layoutEnvironment)
        group.contentInsets = NSDirectionalEdgeInsets(
            top: groupHeaderConstant,
            leading: 0,
            bottom: 0,
            trailing: 0)
        
        return group
    }
    
    private func makeCollectionLayoutSection(
        with group: NSCollectionLayoutGroup,
        for section: SectionModel,
        in layoutEnvironment: NSCollectionLayoutEnvironment
    ) -> NSCollectionLayoutSection {
        let display = self.display
        let layoutSection = NSCollectionLayoutSection(group: group)
        layoutSection.orthogonalScrollingBehavior = section.properties.orthagonalScrollingBehavior
        layoutSection.interGroupSpacing = display.spacing
        layoutSection.contentInsets = display.directionalLayoutMargins
        layoutSection.boundarySupplementaryItems = self.makeCollectionLayoutBoundarySupplementaryItems(
            for: section,
            in: layoutEnvironment)
        
        return layoutSection
    }
    
    private func makeCollectionLayoutBoundarySupplementaryItems(
        for section: SectionModel,
        in layoutEnvironment: NSCollectionLayoutEnvironment
    ) -> [NSCollectionLayoutBoundarySupplementaryItem ]{
        if section.properties.title == nil && section.properties.description == nil { return [] }
        
        let boundarySupplementaryItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44))
        let boundarySupplementaryItem = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: boundarySupplementaryItemSize,
            elementKind: self.boundarySupplementaryItemKind,
            alignment: .top,
            absoluteOffset: CGPoint(x: 0, y: -10))
        
        return [boundarySupplementaryItem]
    }
    
    private func makeCollectionLayoutSupplementaryItems(
        for section: SectionModel,
        in layoutEnvironment: NSCollectionLayoutEnvironment
    ) -> [NSCollectionLayoutSupplementaryItem] {
        if !section.groupProperties.isHeaderEnabled { return [] }
        
        let supplementaryItemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(self.display.groupWidth(for: section)),
            heightDimension: .absolute(30))
        let supplementaryItemAnchor = NSCollectionLayoutAnchor(edges: [.top, .leading])
        let supplementaryItem = NSCollectionLayoutSupplementaryItem(
            layoutSize: supplementaryItemSize,
            elementKind: self.supplementaryItemKind,
            containerAnchor: supplementaryItemAnchor)
        supplementaryItem.contentInsets = .init(top: 0, leading: 0, bottom: 10, trailing: 0)
        
        return [supplementaryItem]
    }
}

// MARK: Collection View
extension SectionCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func reloadData() {
        self.collectionView.reloadData()
    }
    
    final func numberOfSections(
        in collectionView: UICollectionView
    ) -> Int {
        
        return self.dataSource?.numberOfSections(in: self) ?? 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        guard let dataSource = self.dataSource else { return 0 }
        
        let section = dataSource.sectionCollectionViewController(
            self,
            sectionAtIndex: section)
        let numberOfItems = dataSource.sectionCollectionViewController(
            self,
            numberOfItemsInSection: section)
        
        return numberOfItems
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard
            let section = self.dataSource?.sectionCollectionViewController(
                self,
                sectionAtIndex: indexPath.section),
            let item = self.dataSource?.sectionCollectionViewController(
                self,
                itemAtIndex: indexPath.item,
                fromSection: section),
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: self.cellId,
                for: indexPath) as? SectionItemCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        
        let newItem: Itemable
        if section.itemProperties.configuration == .ranked {
            newItem = ItemModel(
                image: item.itemImage,
                headline: "\((indexPath.item % section.itemProperties.itemCount.value(for: self.display.displayMode)) + 1)",
                title: item.itemTitle,
                subtitle: item.itemSubtitle)
        } else if section.itemProperties.configuration == .large {
            newItem = ItemModel(
                image: item.itemImage,
                headline: "TEST HEADLINE",
                title: item.itemTitle,
                subtitle: item.itemSubtitle)
        } else {
            newItem = item
        }
        
        cell.contentView.backgroundColor = .clear
        cell.set(newItem, properties: section.itemProperties, displayMode: self.display.displayMode)
        
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        let collectionReusableView: UICollectionReusableView
        
        if
            kind == self.supplementaryItemKind,
            let groupHeader = collectionView.dequeueReusableSupplementaryView(
                ofKind: self.supplementaryItemKind,
                withReuseIdentifier: self.supplementaryItemId,
                for: indexPath) as? GroupHeaderCollectionReusableView,
            let section = self.dataSource?.sectionCollectionViewController(
                self,
                sectionAtIndex:
                indexPath.section),
            let groupTitle = self.dataSource?.sectionCollectionViewController(
                self,
                groupTitleAtIndex: indexPath.item,
                fromSection: section)
        {
            groupHeader.set(title: groupTitle)
            collectionReusableView = groupHeader
        }
        
        else if
            kind == self.boundarySupplementaryItemKind,
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(
                ofKind: self.boundarySupplementaryItemKind,
                withReuseIdentifier: self.boundarySupplementaryItemId,
                for: indexPath) as? SectionHeaderCollectionReusableView,
            let section = self.dataSource?.sectionCollectionViewController(
                self,
                sectionAtIndex:
                indexPath.section)
        {
            sectionHeader.set(title: section.properties.title ?? "", subtitle: section.properties.description ?? "", indicatorStyle: section.properties.indicatorStyle)
            collectionReusableView = sectionHeader
        }
        
        else {
            collectionReusableView = UICollectionReusableView()
        }
        
        collectionReusableView.backgroundColor = .clear
        return collectionReusableView
    }
}
