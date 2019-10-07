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
        
        self.layout()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        self.layout()
    }
}

extension BaseCollectionViewCell: LayoutConfigurable {
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
    
    public func configureLayout() {}
    
    public func deactivateConstraints() {}
    
    public func activateConstraints() {}
    
    public func configureLayoutForCompactSizeClass() {}
    
    public func configureLayoutForRegularSizeClass() {}
}
