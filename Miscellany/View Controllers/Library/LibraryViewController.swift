//
//  LibraryViewController.swift
//  Miscellany
//
//  Created by Theodore Gallao on 11/6/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

class LibraryViewController: BaseViewController {
    let storyService: StoryService
    let userService: UserService
    let imageService: ImageService
    
    // MARK: Initializers
    init(storyService: StoryService = .shared, userService: UserService = .shared, imageService: ImageService = .shared) {
        self.storyService = storyService
        self.userService = userService
        self.imageService = imageService
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Properties
extension LibraryViewController {
    override func configureProperties() {
        super.configureProperties()
        
        self.extendedLayoutIncludesOpaqueBars = true
        self.edgesForExtendedLayout = [.top]
    }
}

// MARK: Additional
extension LibraryViewController {
    override func configureAdditional() {
        super.configureAdditional()
    }
}

// MARK: Views, Layout & Constraints
extension LibraryViewController {
    override func configureViews() {
        super.configureViews()
        
        self.view.backgroundColor = UIColor(named: "Background")
    }
    
    override func configureLayout() {
        super.configureLayout()
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
}

// MARK: Navigation
extension LibraryViewController {
    override func configureNavigation(_ animated: Bool) {
        super.configureNavigation(animated)
        
        self.navigationItem.title = "Library"
    }
}
