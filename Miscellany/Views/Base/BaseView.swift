//
//  BaseView.swift
//  Miscellany
//
//  Created by Theodore Gallao on 10/1/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

// MARK: Declaration, Data Members, & Initializers
class BaseView: UIView {
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.commonInit()
    }
    
    private func commonInit() {
        self.configureViews()
        
        self.deactivateConstraints()
        self.configureLayout()
        self.activateConstraints()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        self.deactivateConstraints()
        self.configureLayout()
        self.activateConstraints()
    }
}

extension BaseView: LayoutConfigurable {
    open func configureViews() {}

    public func configureLayout() {
        if self.traitCollection.horizontalSizeClass == .compact {
            self.configureLayoutForCompactSizeClass()
        } else {
            self.configureLayoutForRegularSizeClass()
        }
    }
    
    public func deactivateConstraints() {}
    
    public func activateConstraints() {}
    
    func configureLayoutForCompactSizeClass() {}
    
    func configureLayoutForRegularSizeClass() {}
}
