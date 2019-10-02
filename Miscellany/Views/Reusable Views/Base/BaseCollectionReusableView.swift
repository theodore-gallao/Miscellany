//
//  GenericReusableView.swift
//  Miscellany
//
//  Created by Theodore Gallao on 6/13/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

// MARK: Declaration, Data Members, & Initializers
class BaseCollectionReusableView: UICollectionReusableView {
    // Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.commonInit()
    }
    
    open func commonInit() {
        // Override this!
    }
}
