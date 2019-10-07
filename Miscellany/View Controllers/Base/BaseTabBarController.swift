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
        
        self.layout()
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.configureNavigation(animated)
    }
    
    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        self.layout()
    }
}

extension BaseTabBarController: PropertyConfigurable {
    public func configureProperties() {}
}

extension BaseTabBarController: LayoutConfigurable {
    private func layout() {
        self.deactivateConstraints()
        
        self.configureLayout()
        
        if self.traitCollection.horizontalSizeClass == .compact {
            self.configureLayoutForCompactSizeClass()
        } else {
            self.configureLayoutForRegularSizeClass()
        }
        
        self.activateConstraints()
    }
    
    public func configureViews() {}
    
    public func configureLayout() {
        if self.traitCollection.horizontalSizeClass == .compact {
            self.configureLayoutForCompactSizeClass()
        } else {
            self.configureLayoutForRegularSizeClass()
        }
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
