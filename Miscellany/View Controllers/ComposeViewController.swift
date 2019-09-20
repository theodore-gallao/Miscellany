//
//  ComposeViewController.swift
//  Miscellany
//
//  Created by Theodore Gallao on 8/22/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

// MARK: Declaration, Data Members, & Initializers
class ComposeViewController: UIViewController {
    private lazy var cancelBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: self, action: #selector(self.handleCancelBarButtonItem(_:)))
        barButtonItem.tintColor = UIColor(named: "Primary")
        
        return barButtonItem
    }()
    
    private lazy var nextBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Next", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.handleNextBarButtonItem(_:)))
        barButtonItem.tintColor = UIColor(named: "Primary")
        
        return barButtonItem
    }()
}

// MARK: View Controller States
extension ComposeViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Extend layout past navigation and tab bars
        self.extendedLayoutIncludesOpaqueBars = true
        self.edgesForExtendedLayout = [.top]
        
        self.view.backgroundColor = UIColor(named: "Background")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.configureNavigation(animated)
    }
}

// MARK: Navigation
extension ComposeViewController {
    private func configureNavigation(_ animated: Bool) {
        self.configureNavigationBar(animated)
    }
    
    private func configureNavigationBar(_ animated: Bool) {
        self.configureNavigationBarAppearance(animated)
        
        self.navigationItem.title = "Compose"
        
        self.navigationItem.setLeftBarButton(self.cancelBarButtonItem, animated: animated)
        self.navigationItem.setRightBarButton(self.nextBarButtonItem, animated: animated)
    }
    
    private func configureNavigationBarAppearance(_ animated: Bool) {
        if let navigationController = self.navigationController {
            navigationController.navigationBar.tintColor = UIColor(named: "Primary")
            navigationController.navigationBar.barTintColor = UIColor(named: "Background")
            navigationController.navigationBar.prefersLargeTitles = true
            navigationController.navigationBar.isTranslucent = false
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

// MARK: Selectors & Gestures
extension ComposeViewController {
    @objc private func handleCancelBarButtonItem(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func handleNextBarButtonItem(_ sender: UIBarButtonItem) {
        
    }
}
