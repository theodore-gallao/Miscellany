//
//  UIFont+.swift
//  Miscellany
//
//  Created by Theodore Gallao on 9/19/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

public extension UIFont {
    func withTraits(_ traits: UIFontDescriptor.SymbolicTraits...) -> UIFont {
        let descriptor = self.fontDescriptor
            .withSymbolicTraits(UIFontDescriptor.SymbolicTraits(traits))
        return UIFont(descriptor: descriptor!, size: 0)
    }
    
    var italic : UIFont {
        return withTraits(.traitItalic)
    }
    
    var bold : UIFont {
        return withTraits(.traitBold)
    }
}
