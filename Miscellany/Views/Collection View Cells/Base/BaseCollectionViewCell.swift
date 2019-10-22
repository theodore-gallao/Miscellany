//
//  GenericCollectionViewCell.swift
//  Miscellany
//
//  Created by Theodore Gallao on 6/11/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
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
        
        self.configureLayout()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        self.configureLayout()
    }
}

extension BaseCollectionViewCell: LayoutConfigurable {
    func configureViewsForCompactSizeClass() {}
    
    func configureViewsForRegularSizeClass() {}
    
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
