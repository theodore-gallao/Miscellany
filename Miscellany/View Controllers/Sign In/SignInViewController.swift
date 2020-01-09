//
//  SignInViewController.swift
//  Miscellany
//
//  Created by Theodore Gallao on 10/3/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import AuthenticationServices
import FirebaseFunctions

struct FeatureInfoModel {
    var feature: String
    var headline: String
    var description: String
    var image: UIImage?
}

class SignInViewController: BaseViewController {
    let userService: UserService
    
    let features = [
        FeatureInfoModel(feature: "PERSONALIZED EXPERIENCE", headline: "Read more stories you like", description: "We value your interests", image: UIImage(named: "Feature 000")),
        FeatureInfoModel(feature: "READING LIST & LIBRARY", headline: "Save you favorite stories", description: "Never forget them", image: UIImage(named: "Feature 001")),
        FeatureInfoModel(feature: "AUTHOR SUBSCRIPTION", headline: "Follow your favorite authors", description: "Never miss their stories", image: UIImage(named: "Feature 002")),
        FeatureInfoModel(feature: "STORY INTERACTION", headline: "Show your interest!", description: "Like, dislike, or comment on any story", image: UIImage(named: "Feature 003")),
        FeatureInfoModel(feature: "STORY COMPOSITION", headline: "Publish your best stories", description: "Who knows how far you'll go?", image: UIImage(named: "Feature 004")),
    ]
    
    private lazy var collectionViewLayout: UICollectionViewCompositionalLayout = {
        return UICollectionViewCompositionalLayout { (sectionIndex, layouEnvironment) -> NSCollectionLayoutSection? in
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)))
            
            let displayMode = DisplayMode.displayMode(for: self.view.frame.width)
            let directionalLayoutMargins = displayMode.directionalLayoutMargins
            let groupSpacing = displayMode.spacing
            self.view.directionalLayoutMargins = directionalLayoutMargins
            self.navigationController?.navigationBar.directionalLayoutMargins = directionalLayoutMargins
            let marginedWidth = self.view.layoutMarginsGuide.layoutFrame.width
            
            let heightMultiplier: CGFloat = 2 / 3
            let heightConstant: CGFloat = 74
            let numberOfColumns: CGFloat
            switch displayMode {
            case .compact:
                numberOfColumns = 1
            case .standard:
                numberOfColumns = 1.5
            case .large:
                numberOfColumns = 1.5
            case .extraLarge:
                numberOfColumns = 2
            }
            
            let width = ((marginedWidth - (groupSpacing * (numberOfColumns - 1))) / numberOfColumns)
            let height = ((width * heightMultiplier) + heightConstant) * 1
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .absolute(width),
                heightDimension: .absolute(height))
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: groupSize,
                subitem: item,
                count: 1)
             
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPaging
            section.interGroupSpacing = groupSpacing
            section.contentInsets = displayMode.directionalLayoutMargins
            
            
            return section
        }
    }()
    
    // MARK: Views
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.collectionViewLayout)
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
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
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
        button.cornerRadius = 22
        button.translatesAutoresizingMaskIntoConstraints = false
            
        return button
    }()
    
    lazy var guestSignInButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(self.handleGuestSignInButton(_:)), for: .touchUpInside)
        button.backgroundColor = .clear
        button.tintColor = UIColor(named: "Primary")
        button.setTitle("Continue as a guest", for: UIControl.State.normal)
        button.setTitleColor(UIColor(named: "Primary"), for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.semibold)
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
    
    init(userService: UserService = .shared) {
        self.userService = userService
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Views, Layout & Constraints
extension SignInViewController {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.appleSignInButton.removeFromSuperview()
        
        let button = ASAuthorizationAppleIDButton(type: .signIn, style: self.traitCollection.userInterfaceStyle == .dark ? .white : .black)
        button.addTarget(self, action: #selector(self.handleAppleSignInButton(_:)), for: .touchUpInside)
        button.cornerRadius = 22
        button.translatesAutoresizingMaskIntoConstraints = false
        
        self.appleSignInButton = button
        
        self.configureViews()
        
        super.traitCollectionDidChange(previousTraitCollection)
    }
    
    override func configureViews() {
        super.configureViews()
        
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(self.collectionView)
        self.view.addSubview(self.subtitleLabel)
        self.view.addSubview(self.appleSignInButton)
        self.view.addSubview(self.guestSignInButton)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { _ in
            self.collectionView.collectionViewLayout.invalidateLayout()
            self.configureLayout()
            self.view.layoutIfNeeded()
        }, completion: nil)
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
            self.subtitleLabel.leadingAnchor.constraint(equalTo: self.view.readableContentGuide.leadingAnchor),
            self.subtitleLabel.trailingAnchor.constraint(equalTo: self.view.readableContentGuide.trailingAnchor),
        ]
        
        self.appleSignInButtonConstraints = [
            self.appleSignInButton.heightAnchor.constraint(equalToConstant: 44),
            self.appleSignInButton.leadingAnchor.constraint(equalTo: self.view.readableContentGuide.leadingAnchor),
            self.appleSignInButton.trailingAnchor.constraint(equalTo: self.view.readableContentGuide.trailingAnchor),
            self.appleSignInButton.bottomAnchor.constraint(equalTo: self.guestSignInButton.topAnchor, constant: -10)
        ]
        
        self.guestSignInButtonConstraints = [
            self.guestSignInButton.leadingAnchor.constraint(equalTo: self.view.readableContentGuide.leadingAnchor),
            self.guestSignInButton.trailingAnchor.constraint(equalTo: self.view.readableContentGuide.trailingAnchor),
            self.guestSignInButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -32)
        ]
    }
    
    override func configureLayoutForRegularSizeClass() {
        super.configureLayoutForRegularSizeClass()
        
        self.collectionViewConstraints = [
            self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ]
        
        self.subtitleLabelConstraints = [
            self.subtitleLabel.bottomAnchor.constraint(equalTo: self.appleSignInButton.topAnchor, constant: -10),
            self.subtitleLabel.leadingAnchor.constraint(equalTo: self.view.readableContentGuide.leadingAnchor),
            self.subtitleLabel.trailingAnchor.constraint(equalTo: self.view.readableContentGuide.trailingAnchor),
        ]
        
        self.appleSignInButtonConstraints = [
            self.appleSignInButton.heightAnchor.constraint(equalToConstant: 50),
            self.appleSignInButton.leadingAnchor.constraint(equalTo: self.view.readableContentGuide.leadingAnchor),
            self.appleSignInButton.trailingAnchor.constraint(equalTo: self.view.readableContentGuide.trailingAnchor),
            self.appleSignInButton.bottomAnchor.constraint(equalTo: self.guestSignInButton.topAnchor, constant: -10)
        ]
        
        self.guestSignInButtonConstraints = [
            self.guestSignInButton.leadingAnchor.constraint(equalTo: self.view.readableContentGuide.leadingAnchor),
            self.guestSignInButton.trailingAnchor.constraint(equalTo: self.view.readableContentGuide.trailingAnchor),
            self.guestSignInButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -32)
        ]
    }
}

// MARK: Navigation
extension SignInViewController {
    override func configureNavigation(_ animated: Bool) {
        super.configureNavigation(animated)
        
        self.navigationItem.title = "Sign In"
        
        self.navigationItem.setRightBarButton(self.notNowButton, animated: animated)
        
        if let navigationController = self.navigationController {
            navigationController.setNavigationBarHidden(false, animated: animated)
            navigationController.navigationBar.prefersLargeTitles = true
            navigationController.navigationBar.tintColor = UIColor(named: "Primary")
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

extension SignInViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let credentials as ASAuthorizationAppleIDCredential:
            let subscriptions = [
                BaseUser(id: "000", firstName: "Jonathan", lastName: "Appleseed", username: "j_appleseed"),
                BaseUser(id: "001", firstName: "Linda", lastName: "Mendes", username: "_itslinda"),
                BaseUser(id: "002", firstName: "Arthur", lastName: "Adams", username: "real_arthur_adams"),
                BaseUser(id: "003", firstName: "Abigail", lastName: "Larsson", username: "abbylarson94"),
                BaseUser(id: "004", firstName: "Eric", lastName: "Cruz",  username: "cruzing_")
            ]
                
            let likedGenres = [
                BaseGenre(id: "000", title: "Adventure", storyCount: 0),
                BaseGenre(id: "002", title: "Fantasy", storyCount: 0),
                BaseGenre(id: "003", title: "Horror", storyCount: 0),
                BaseGenre(id: "005", title: "Mystery", storyCount: 0),
                BaseGenre(id: "007", title: "Science Fiction", storyCount: 0),
                BaseGenre(id: "008", title: "Thriller", storyCount: 0),
            ]
            
            let user = User(
                id: credentials.user,
                dateCreated: Date(),
                dateUpdated: Date(),
                isRegistered: true,
                firstName: credentials.fullName?.givenName ?? "",
                lastName: credentials.fullName?.familyName ?? "",
                email: credentials.email ?? "",
                username: "",
                storyCount: 0,
                subscriberCount: 0,
                subscribedCount: 0,
                subscriptions: subscriptions,
                likedGenres: likedGenres)
            
            self.userService.currentUser = user
            
            let userFormViewController = UserFormViewController(user: user)
            userFormViewController.isModalInPresentation = true
            
            self.navigationController?.pushViewController(userFormViewController, animated: true)
        case let credentials as ASPasswordCredential:
            break
        default: break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("authorizationController Error: \(error.localizedDescription)")
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return UIWindow(frame: UIScreen.main.bounds)
    }
}

// MARK: Selectors
extension SignInViewController {
    @objc private func handleAppleSignInButton(_ sender: ASAuthorizationAppleIDButton) {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    @objc private func handleNotNowBarButtonItem(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func handleGuestSignInButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
