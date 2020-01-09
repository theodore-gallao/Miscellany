//
//  BaseTabBarController.swift
//  Miscellany
//
//  Created by Theodore Gallao on 9/27/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

public class BaseTabBarController: UITabBarController {
    /// DO NOT CALL THIS!
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureViews()
        self.configureProperties()
        self.configureAdditional()
        
        self.configureLayout()
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.configureNavigation(animated)
    }
    
    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        self.configureLayout()
    }
}

extension BaseTabBarController: PropertyConfigurable {
    public func configureProperties() {}
}

extension BaseTabBarController: LayoutConfigurable {
    public func configureViewsForCompactSizeClass() {}
    
    public func configureViewsForRegularSizeClass() {}
    
    public func configureViews() {}
    
    public func configureLayout() {
        self.deactivateConstraints()
        
        if self.traitCollection.horizontalSizeClass == .compact {
            self.configureLayoutForCompactSizeClass()
            self.configureViewsForCompactSizeClass()
        } else {
            self.configureLayoutForRegularSizeClass()
            self.configureViewsForRegularSizeClass()
        }
        
        self.activateConstraints()
    }
    
    public func deactivateConstraints() {}
    
    public func activateConstraints() {}
    
    public func configureLayoutForCompactSizeClass() {}
    
    public func configureLayoutForRegularSizeClass() {}
}

extension BaseTabBarController: AdditionalConfigurable {
    public func configureAdditional() {}
}

extension BaseTabBarController: NavigationConfigurable {
    public func configureNavigation(_ animated: Bool) {}
}
