//
//  ViewController.swift
//  Miscellany
//
//  Created by Theodore Gallao on 9/27/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol PropertyConfigurable {
    /// Override this method to configure any properties of this `BaseViewController`.
    func configureProperties()
}

@objc public protocol LayoutConfigurable {
    /// Override this method to confiure the `UIView`and its subviews of this `BaseViewController`. This is mainly used to add subviews set this view's properties.
    func configureViews()
    
    /// Override this method to configure any layout constraints. This method will be called on viewDidLoad() and traitCollectionDidChange(), so it will account for initial layout as well as adaptive layout
    func configureLayout()
}

@objc public protocol AdditionalConfigurable {
    /// Override this method to configure any additional setup required
    func configureAdditional()
}

@objc public protocol NavigationConfigurable {
    /// Override this method to configure any navigation properties
    func configureNavigation(_ animated: Bool)
}

public class BaseViewController: UIViewController {
    
    /// DO NOT CALL THIS!
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureViews()
        self.configureProperties()
        self.configureLayout()
        self.configureAdditional()
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

extension BaseViewController: PropertyConfigurable {
    public func configureProperties() {}
}

extension BaseViewController: LayoutConfigurable {
    public func configureViews() {}
    
    public func configureLayout() {}
}

extension BaseViewController: AdditionalConfigurable {
    public func configureAdditional() {}
}

extension BaseViewController: NavigationConfigurable {
    public func configureNavigation(_ animated: Bool) {}
}
