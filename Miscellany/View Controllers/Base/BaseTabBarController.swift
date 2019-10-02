//
//  BaseTabBarController.swift
//  Miscellany
//
//  Created by Theodore Gallao on 9/27/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

class BaseTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureLayout()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        self.configureLayout()
    }
    
    /// Override this method to configure any layout constraints. This method will be called on viewDidLoad() and traitCollectionDidChange(), so it will account for initial layout as well as adaptive layout
    public func configureLayout() {
        
    }
}
