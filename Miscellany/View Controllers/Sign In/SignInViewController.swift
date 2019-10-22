//
//  SignInViewController.swift
//  Miscellany
//
//  Created by Theodore Gallao on 10/3/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit
import AuthenticationServices

struct FeatureInfoModel {
    var feature: String
    var headline: String
    var description: String
    var image: UIImage?
}

class SignInViewController: BaseViewController {
    let features = [
        FeatureInfoModel(feature: "PERSONALIZED EXPERIENCE", headline: "Read more stories you like", description: "We value your preferences"),
        FeatureInfoModel(feature: "READING LIST & LIBRARY", headline: "Save your favorite stories", description: "Add them to your library, or save them for later"),
        FeatureInfoModel(feature: "AUTHOR SUBSCRIPTION", headline: "Subscribe to your favorite authors", description: "Receive important notifications related to them"),
        FeatureInfoModel(feature: "STORY INTERACTION", headline: "Show your interest!", description: "Like, dislike, or comment on any story"),
        FeatureInfoModel(feature: "STORY COMPOSITION", headline: "Who knows how far you'll go?", description: "Write and publish your best stories"),
    ]
    
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
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
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
        
        collectionView.register(FeatureInfoCollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.Id.featureInfo.rawValue)
        
        return collectionView
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Streamline your experience and enable Miscellany's powerful features by signing in now."
        label.backgroundColor = UIColor.clear
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.textColor = UIColor(named: "Subtext")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        
        return label
    }()
    
    lazy var appleSignInButton: ASAuthorizationAppleIDButton = {
        let button = ASAuthorizationAppleIDButton(type: .signIn, style: self.traitCollection.userInterfaceStyle == .dark ? .white : .black)
        button.addTarget(self, action: #selector(self.handleAppleSignInButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
            
        return button
    }()
    
    lazy var guestSignInButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(self.handleGuestSignInButton(_:)), for: .touchUpInside)
        button.backgroundColor = UIColor(named: "Background")
        button.tintColor = UIColor(named: "Primary")
        button.setTitle("Continue as a guest", for: UIControl.State.normal)
        button.setTitleColor(UIColor(named: "Primary"), for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.bold)
        button.titleLabel?.textAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var notNowButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Not Now", style: .done, target: self, action: #selector(self.handleNotNowBarButtonItem(_:)))
        
        return barButtonItem
    }()
    
    var collectionViewConstraints = [NSLayoutConstraint]()
    var subtitleLabelConstraints = [NSLayoutConstraint]()
    var appleSignInButtonConstraints = [NSLayoutConstraint]()
    var guestSignInButtonConstraints = [NSLayoutConstraint]()
}

// MARK: Views, Layout & Constraints
extension SignInViewController {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.appleSignInButton.removeFromSuperview()
        
        let button = ASAuthorizationAppleIDButton(type: .signIn, style: self.traitCollection.userInterfaceStyle == .dark ? .white : .black)
        button.addTarget(self, action: #selector(self.handleAppleSignInButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        self.appleSignInButton = button
        
        self.configureViews()
        
        super.traitCollectionDidChange(previousTraitCollection)
    }
    
    override func configureViews() {
        super.configureViews()
        
        self.view.backgroundColor = UIColor(named: "Background")
        
        self.view.addSubview(self.collectionView)
        self.view.addSubview(self.subtitleLabel)
        self.view.addSubview(self.appleSignInButton)
        self.view.addSubview(self.guestSignInButton)
    }
    
    override func configureLayout() {
        super.configureLayout()
    }
    
    override func deactivateConstraints() {
        super.deactivateConstraints()
        
        NSLayoutConstraint.deactivate(self.collectionViewConstraints)
        NSLayoutConstraint.deactivate(self.subtitleLabelConstraints)
        NSLayoutConstraint.deactivate(self.appleSignInButtonConstraints)
        NSLayoutConstraint.deactivate(self.guestSignInButtonConstraints)
    }
    
    override func activateConstraints() {
        super.activateConstraints()
        
        NSLayoutConstraint.activate(self.collectionViewConstraints)
        NSLayoutConstraint.activate(self.subtitleLabelConstraints)
        NSLayoutConstraint.activate(self.appleSignInButtonConstraints)
        NSLayoutConstraint.activate(self.guestSignInButtonConstraints)
    }
    
    override func configureLayoutForCompactSizeClass() {
        super.configureLayoutForCompactSizeClass()
        
        self.collectionViewConstraints = [
            self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ]
        
        self.subtitleLabelConstraints = [
            self.subtitleLabel.bottomAnchor.constraint(equalTo: self.appleSignInButton.topAnchor, constant: -10),
            self.subtitleLabel.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor),
            self.subtitleLabel.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor),
        ]
        
        self.appleSignInButtonConstraints = [
            self.appleSignInButton.heightAnchor.constraint(equalToConstant: 44),
            self.appleSignInButton.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor),
            self.appleSignInButton.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor),
            self.appleSignInButton.bottomAnchor.constraint(equalTo: self.guestSignInButton.topAnchor, constant: -10)
        ]
        
        self.guestSignInButtonConstraints = [
            self.guestSignInButton.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor),
            self.guestSignInButton.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor),
            self.guestSignInButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -32)
        ]
    }
    
    override func configureLayoutForRegularSizeClass() {
        super.configureLayoutForRegularSizeClass()
        
    }
}

// MARK: Navigation
extension SignInViewController {
    override func configureNavigation(_ animated: Bool) {
        super.configureNavigation(animated)
        
        self.navigationItem.title = "Sign In"
        
        self.navigationItem.setRightBarButton(self.notNowButton, animated: animated)
        
        if let navigationController = self.navigationController {
            navigationController.view.backgroundColor = UIColor(named: "Background")
            navigationController.setNavigationBarHidden(false, animated: animated)
            navigationController.navigationBar.barStyle = .default
            navigationController.navigationBar.tintColor = UIColor(named: "Primary")
            navigationController.navigationBar.barTintColor = UIColor(named: "Background")
            navigationController.navigationBar.isTranslucent = false
            navigationController.navigationBar.prefersLargeTitles = true
            navigationController.navigationBar.shadowImage = UIImage()
            navigationController.navigationBar.titleTextAttributes = [
                 NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.black)
            ]
            navigationController.navigationBar.largeTitleTextAttributes = [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 34, weight: UIFont.Weight.black)
            ]
        }
    }
}

// MARK: Collection View
extension SignInViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.features.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell.Id.featureInfo.rawValue, for: indexPath) as! FeatureInfoCollectionViewCell
        cell.set(self.features[indexPath.row])
        
        return cell
    }
}

// MARK: Selectors
extension SignInViewController {
    @objc private func handleAppleSignInButton(_ sender: ASAuthorizationAppleIDButton) {
        
    }
    
    @objc private func handleNotNowBarButtonItem(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func handleGuestSignInButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
