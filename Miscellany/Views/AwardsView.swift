//
//  AwardsView.swift
//  Miscellany
//
//  Created by Theodore Gallao on 10/1/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

protocol AwardsViewDelegate {
    func awardsView(_ awardsView: AwardsView, didSelect award: AwardModel)
}

class AwardsView: BaseView {
    private(set) var awards: [AwardModel] = []
    
    private let topSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Empty")
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.collectionViewCompositionalLayout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = false
        collectionView.isPagingEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(AwardCollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.Id.award.rawValue)
        
        return collectionView
    }()
    
    private lazy var collectionViewCompositionalLayout: UICollectionViewCompositionalLayout = {
        return UICollectionViewCompositionalLayout { (sectionIndex, layouEnvironment) -> NSCollectionLayoutSection? in
            let isCompact = self.traitCollection.horizontalSizeClass == .compact
            let sizeClassConstant: CGFloat = isCompact ? 32 : 64
            let width = self.frame.width - sizeClassConstant
            let leftMargin = sizeClassConstant / 2
            let rightMargin = (sizeClassConstant / 2)
            
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
    
    private let bottomSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Empty")
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var topSeparatorViewConstraints = [NSLayoutConstraint]()
    private var collectionViewConstraints = [NSLayoutConstraint]()
    private var bottomSeparatorViewConstraints = [NSLayoutConstraint]()
    
    func set(_ awards: [AwardModel]) {
        self.awards = awards
        
        self.collectionView.reloadData()
    }
}

extension AwardsView {
    override func configureViews() {
        super.configureViews()
        
        self.addSubview(self.topSeparatorView)
        self.addSubview(self.collectionView)
        self.addSubview(self.bottomSeparatorView)
    }
    
    override func configureLayout() {
        super.configureLayout()
        
        NSLayoutConstraint.deactivate(self.topSeparatorViewConstraints)
        NSLayoutConstraint.deactivate(self.collectionViewConstraints)
        NSLayoutConstraint.deactivate(self.bottomSeparatorViewConstraints)
        
        self.topSeparatorViewConstraints = [
            self.topSeparatorView.heightAnchor.constraint(equalToConstant: 0.75),
            self.topSeparatorView.topAnchor.constraint(equalTo: self.topAnchor),
            self.topSeparatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.topSeparatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ]
        
        self.collectionViewConstraints = [
            self.collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
        
        self.bottomSeparatorViewConstraints = [
            self.bottomSeparatorView.heightAnchor.constraint(equalToConstant: 0.75),
            self.bottomSeparatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.bottomSeparatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.bottomSeparatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(self.topSeparatorViewConstraints)
        NSLayoutConstraint.activate(self.collectionViewConstraints)
        NSLayoutConstraint.activate(self.bottomSeparatorViewConstraints)
    }
}

extension AwardsView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.awards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell.Id.award.rawValue, for: indexPath) as! AwardCollectionViewCell
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        
        return cell
    }
}
