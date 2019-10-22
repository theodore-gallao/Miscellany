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
        navigationController.navigationBar.prefersLargeTitles = true
        
        let standard = UINavigationBarAppearance()
        standard.configureWithDefaultBackground()
        standard.backgroundColor = UIColor(named: "Background")
        standard.shadowColor = .opaqueSeparator
        standard.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 18, weight: .heavy)]
        standard.largeTitleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 34, weight: .heavy)]
        
        
        let scrollEdge = UINavigationBarAppearance()
        scrollEdge.configureWithTransparentBackground()
        scrollEdge.shadowColor = nil
        scrollEdge.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 18, weight: .heavy)]
        scrollEdge.largeTitleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 34, weight: .heavy)]
        
        navigationController.navigationBar.standardAppearance = standard
        navigationController.navigationBar.scrollEdgeAppearance = scrollEdge
        
        let compactInline = UITabBarItemAppearance(style: .compactInline)
        compactInline.selected.iconColor = UIColor(named: "Primary")
        compactInline.selected.titleTextAttributes = [
            .foregroundColor: UIColor(named: "Primary") ?? .systemRed]
        
        compactInline.normal.iconColor = UIColor.secondaryLabel
        compactInline.normal.titleTextAttributes = [
            .foregroundColor: UIColor.secondaryLabel]
        
        let image = UIImage(named: "Home")
        let item = UITabBarItem(title: nil, image: image, selectedImage: image)
        item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        navigationController.tabBarItem = item
        
        return navigationController
    }()
    
    private lazy var searchNavigationController: UINavigationController = {
        let viewController = SearchViewController(imageService: self.imageService)
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
        
        let image = UIImage(named: "Search")
        let item = UITabBarItem(title: nil, image: image, selectedImage: image)
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
        let viewController = NotificationViewController()
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
        
        let image = UIImage(named: "Bell")
        let item = UITabBarItem(title: nil, image: image, selectedImage: image)
        item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        navigationController.tabBarItem = item
        
        return navigationController
    }()
    
    private lazy var libraryNavigationController: UINavigationController = {
        let viewController = MenuViewController()
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
        
        let image = UIImage(named: "More")
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
        self.configureTabBar()
    }
    
    override func configureViewsForCompactSizeClass() {
        super.configureViewsForCompactSizeClass()
    }
    
    override func configureViewsForRegularSizeClass() {
        super.configureViewsForRegularSizeClass()
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
        let stacked = UITabBarItemAppearance(style: .stacked)
        stacked.selected.iconColor = UIColor(named: "Primary")
        stacked.selected.titleTextAttributes = [
            .foregroundColor: UIColor(named: "Primary") ?? .systemRed]
        stacked.normal.iconColor = UIColor(named: "Unselected")
        stacked.normal.titleTextAttributes = [
            .foregroundColor: UIColor(named: "Unselected") ?? UIColor.secondaryLabel]
        
        let inline = UITabBarItemAppearance(style: .inline)
        inline.selected.iconColor = UIColor(named: "Primary")
        inline.selected.titleTextAttributes = [
            .foregroundColor: UIColor(named: "Primary") ?? .systemRed]
        inline.normal.iconColor = UIColor(named: "Unselected")
        inline.normal.titleTextAttributes = [
            .foregroundColor: UIColor(named: "Unselected") ?? UIColor.secondaryLabel]
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "Background")
        appearance.shadowColor = .opaqueSeparator
        appearance.stackedLayoutAppearance = stacked
        appearance.compactInlineLayoutAppearance = stacked
        appearance.inlineLayoutAppearance = inline
        
        self.tabBar.standardAppearance = appearance
    }
}

extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController is ComposeViewController {
            if self.userService.currentUser?.isAnonymous ?? true {
                let composeViewController = ComposeViewController()
                let navigationController = UINavigationController(rootViewController: composeViewController)
                navigationController.modalPresentationStyle = .pageSheet
                
                self.present(navigationController, animated: true, completion: nil)
            } else {
                print("non anonymous user")
            }
            
            return false
        }
        
        return true
    }
}
