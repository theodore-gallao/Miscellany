//
//  ContentView.swift
//  Miscellany
//
//  Created by Theodore Gallao on 6/11/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import UIKit
import AuthenticationServices
import Combine

// MARK: Declaration, Data Members, & Initializers
class MainTabBarController: BaseTabBarController {
    // Services
    let userService: UserService
    let storyService: StoryService
    let imageService: ImageService
    
    // Managers
    let settingsManager: SettingsManager
 
    // Navigation Controllers (The roots of the tabs)
    private lazy var homeNavigationController: UINavigationController = {
        let viewController = HomeViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.prefersLargeTitles = true
        
        let image = UIImage(named: "Home")
        let item = UITabBarItem(title: nil, image: image, selectedImage: image)
        item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        navigationController.tabBarItem = item
        
        return navigationController
    }()
    
    private lazy var searchNavigationController: UINavigationController = {
        let viewController = BrowseViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.prefersLargeTitles = true
        
        let image = UIImage(named: "Search")
        let item = UITabBarItem(title: nil, image: image, selectedImage: image)
        item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        navigationController.tabBarItem = item
        
        return navigationController
    }()
    
    private lazy var composeViewController: ComposeViewController = {
        let viewController = ComposeViewController()
        
        let image = UIImage(named: "Compose")
        let item = UITabBarItem(title: nil, image: image, selectedImage: image)
        item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        viewController.tabBarItem = item
        
        return viewController
    }()
    
    private lazy var notificationsNavigationController: UINavigationController = {
        let viewController = NotificationViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.prefersLargeTitles = true
        
        let image = UIImage(named: "Bell")
        let item = UITabBarItem(title: nil, image: image, selectedImage: image)
        item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        navigationController.tabBarItem = item
        
        return navigationController
    }()
    
    private lazy var profileNavigationController: UINavigationController = {
        let viewController = ProfileViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.prefersLargeTitles = true
        
        let image = UIImage(named: "Person")
        let item = UITabBarItem(title: nil, image: image, selectedImage: image)
        item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        navigationController.tabBarItem = item
        
        return navigationController
    }()
    
    // MARK: Initializers
    init(
        userService: UserService = .shared,
        storyService: StoryService = .shared,
        imageService: ImageService = .shared,
        settingsManager: SettingsManager = .shared)
    {
        self.userService = userService
        self.storyService = storyService
        self.imageService = imageService
        self.settingsManager = settingsManager
        
        super.init(nibName: nil, bundle: nil)
        
        self.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Views, Layout & Constraints
extension MainTabBarController {
    override func configureViews() {
        super.configureViews()
        
        self.view.backgroundColor = UIColor(named: "Background")
        
        self.configureViewControllers()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { _ in
            self.configureLayout()
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    override func configureLayout() {
        super.configureLayout()
        
        self.view.directionalLayoutMargins = self.displayMode.directionalLayoutMargins
        self.navigationController?.navigationBar.directionalLayoutMargins = self.displayMode.directionalLayoutMargins
    }
    
    override func configureViewsForCompactSizeClass() {
        super.configureViewsForCompactSizeClass()
        
        self.viewControllers?.forEach({ (viewController) in
            viewController.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        })
    }
    
    override func configureViewsForRegularSizeClass() {
        super.configureViewsForRegularSizeClass()
        
        self.viewControllers?.forEach({ (viewController) in
            viewController.tabBarItem.imageInsets = UIEdgeInsets.zero
        })
    }
    
    override func deactivateConstraints() {
        super.deactivateConstraints()
    }
    
    override func activateConstraints() {
        super.activateConstraints()
    }
    
    override func configureLayoutForCompactSizeClass() {
        super.configureLayoutForCompactSizeClass()
    }
    
    override func configureLayoutForRegularSizeClass() {
        super.configureLayoutForRegularSizeClass()
    }
    
    private func configureViewControllers() {
        self.setViewControllers(
            [
                self.homeNavigationController,
                self.searchNavigationController,
                self.composeViewController,
                self.notificationsNavigationController,
                self.profileNavigationController],
            animated: false)
    }
}

// MARK: Tab Bar Controller Delegate
extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController is ComposeViewController {
            if self.userService.currentUser.isRegistered {
                self.presentCompose(completion: nil)
            } else {
                self.userService.presentSignIn(in: self, completion: nil)
            }
            
            return false
        }
        
        return true
    }
    
    private func presentCompose(completion: (() -> Void)?) {
        let composeViewController = ComposeViewController()
        let navigationController = UINavigationController(rootViewController: composeViewController)
        navigationController.modalPresentationStyle = .pageSheet
        
        self.present(navigationController, animated: true, completion: completion)
    }
}

// MARK: Selectors & Gestures
extension MainTabBarController {
    
}
