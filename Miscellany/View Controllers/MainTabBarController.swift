//
//  ContentView.swift
//  Miscellany
//
//  Created by Theodore Gallao on 6/11/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import UIKit

// MARK: Declaration, Data Members, & Initializers
class MainTabBarController: UITabBarController {
    // Navigation Controllers (The roots of the tabs)
    private lazy var homeNavigationController: UINavigationController = {
        let navigationController = UINavigationController(rootViewController: self.homeViewController)
        
        navigationController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: "Home"),
            selectedImage: UIImage(named: "Home"))
        
        return navigationController
    }()
    
    private lazy var searchNavigationController: UINavigationController = {
        let navigationController = UINavigationController(rootViewController: UIViewController())
        
        navigationController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: "Search"),
            selectedImage: UIImage(named: "Search"))
        
        return navigationController
    }()
    
    private lazy var composeViewController: ComposeViewController = {
        let viewController = ComposeViewController()
        
        let item = UITabBarItem(
            title: nil,
            image: UIImage(named: "Create"),
            selectedImage: UIImage(named: "Create"))
        viewController.tabBarItem = item
        
        return viewController
    }()
    
    private lazy var inboxNavigationController: UINavigationController = {
        let navigationController = UINavigationController(rootViewController: UIViewController())
        
        navigationController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: "Inbox"),
            selectedImage: UIImage(named: "Inbox"))
        
        return navigationController
    }()
    
    private lazy var libraryNavigationController: UINavigationController = {
        let navigationController = UINavigationController(rootViewController: UIViewController())
        
        navigationController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: "Library"),
            selectedImage: UIImage(named: "Library"))
        
        return navigationController
    }()
    
    // View Controllers (The roots of the navigation controllers
    private lazy var homeViewController: HomeViewController = {
        let homeViewController = HomeViewController()
        
        return homeViewController
    }()
}

// MARK: View Controller States
extension MainTabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        self.view.backgroundColor = UIColor(named: "Background")
        
        self.setViewControllers([
            self.homeNavigationController,
            self.searchNavigationController,
            self.composeViewController,
            self.inboxNavigationController,
            self.libraryNavigationController], animated: false)
        
        self.configureTabBar()
    }
}

// MARK: Tab Bar
extension MainTabBarController {
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

extension MainTabBarController : UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController is ComposeViewController {
            self.presentComposeViewController()
            
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
