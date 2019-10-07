//
//  ContentView.swift
//  Miscellany
//
//  Created by Theodore Gallao on 6/11/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import UIKit

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
        let viewController = HomeViewController(
            userService: self.userService,
            storyService: self.storyService,
            imageService: self.imageService,
            settingsManager: self.settingsManager)
        let navigationController = UINavigationController(rootViewController: viewController)
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
        
        let item = UITabBarItem(title: nil, image: UIImage(named: "Home"), selectedImage: UIImage(named: "Home"))
        item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        navigationController.tabBarItem = item
        
        return navigationController
    }()
    
    private lazy var searchNavigationController: UINavigationController = {
        let viewController = UIViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        let item = UITabBarItem(title: nil, image: UIImage(named: "Search"), selectedImage: UIImage(named: "Search"))
        item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        navigationController.tabBarItem = item
        
        return navigationController
    }()
    
    private lazy var composeViewController: ComposeViewController = {
        let viewController = ComposeViewController()
        let item = UITabBarItem(title: nil, image: UIImage(named: "Create"), selectedImage: UIImage(named: "Create"))
        item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        viewController.tabBarItem = item
        
        return viewController
    }()
    
    private lazy var inboxNavigationController: UINavigationController = {
        let viewController = UIViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        let item = UITabBarItem(title: nil, image: UIImage(named: "Inbox"), selectedImage: UIImage(named: "Inbox"))
        item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        navigationController.tabBarItem = item
        
        return navigationController
    }()
    
    private lazy var libraryNavigationController: UINavigationController = {
        let viewController = UIViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        let item = UITabBarItem(title: nil, image: UIImage(named: "Library"), selectedImage: UIImage(named: "Library"))
        item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        navigationController.tabBarItem = item
        
        return navigationController
    }()
    
    // MARK: Initializers
    init(
        userService: UserService,
        storyService: StoryService,
        imageService: ImageService,
        settingsManager: SettingsManager)
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
    
    // MARK: View Controller States
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(named: "Background")
        
        self.configureViewControllers()
        self.configureTabBar()
    }
    
    private func configureViewControllers() {
        self.setViewControllers(
            [
                self.homeNavigationController,
                self.searchNavigationController,
                self.composeViewController,
                self.inboxNavigationController,
                self.libraryNavigationController],
            animated: false)
    }
    
    // MARK: Tab Bar
    private func configureTabBar() {
        self.configureTabBarAppearance()
    }
    
    private func configureTabBarAppearance() {
        self.tabBar.tintColor = UIColor(named: "Primary")
        self.tabBar.barTintColor = UIColor(named: "Background")
        self.tabBar.unselectedItemTintColor = UIColor(named: "Unselected")
        self.tabBar.isTranslucent = false
        self.tabBar.shadowImage = UIImage()
        self.tabBar.layer.borderWidth = 0
        self.tabBar.clipsToBounds = true
    }
}

extension MainTabBarController {
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

extension MainTabBarController : UITabBarControllerDelegate {
    func tabBarController(
        _ tabBarController: UITabBarController,
        shouldSelect viewController: UIViewController) -> Bool
    {
        if viewController is ComposeViewController {
            if let currentUser = self.userService.currentUser {
                print(currentUser.id)
                self.presentComposeViewController()
            } else {
                self.userService.presentSignIn(in: self)
            }
            
            return false
        }
        
        return true
    }
    
    private func presentComposeViewController() {
        let navigationController = UINavigationController(rootViewController: ComposeViewController())
        navigationController.modalPresentationStyle = .pageSheet
        
        self.present(navigationController, animated: true, completion: nil)
    }
}
