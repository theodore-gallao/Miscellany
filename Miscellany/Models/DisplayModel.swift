//
//  Display.swift
//  Miscellany
//
//  Created by Theodore Gallao on 10/16/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

enum DisplayMode {
    case compact
    case standard
    case large
    case extraLarge
}

struct DisplayModel {
    /// The width of this section display
    var width: CGFloat
    
    /// The margined width of this section display
    var marginedWidth: CGFloat {
        let leadingMargin = self.directionalLayoutMargins.leading
        let trailingMargin = self.directionalLayoutMargins.trailing
        
        return self.width - leadingMargin - trailingMargin
    }
    
    /// The spacing of this section display
    var spacing: CGFloat {
        switch displayMode {
        case .compact: return 10
        case .standard: return 15
        case .large: return 20
        case .extraLarge: return 25
        }
    }
    
    /// The directional layout margins of this section display
    var directionalLayoutMargins: NSDirectionalEdgeInsets {
        switch displayMode {
        case .compact: return NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        case .standard: return NSDirectionalEdgeInsets(top: 0, leading: 32, bottom: 0, trailing: 32)
        case .large: return NSDirectionalEdgeInsets(top: 0, leading: 44, bottom: 0, trailing: 44)
        case .extraLarge: return NSDirectionalEdgeInsets(top: 0, leading: 64, bottom: 0, trailing: 64)
        }
    }
    
    func groupWidth(for section: SectionModel) -> CGFloat {
        if section.properties.orthagonalScrollingBehavior == .none {
            return self.marginedWidth
        } else {
            let floatCount = section.groupProperties.columnCount.value(for: self.displayMode)
            let totalSpacing = (self.spacing * (floatCount - 1))
            
            return (self.marginedWidth - totalSpacing) / floatCount
        }
    }
    
    func groupHeight(for section: SectionModel) -> CGFloat {
        let groupWidth = self.groupWidth(for: section)
        let heightConstant = section.itemProperties.heightConstant.value(for: self.displayMode)
        let aspectRatio = section.itemProperties.imageAspectRatio
        
        if section.groupProperties.layoutDirection == .vertical {
            let itemFloatCount = CGFloat(section.itemProperties.itemCount.value(for: self.displayMode))
            let itemSpacing = section.itemProperties.spacingConstant.value(for: self.displayMode)
            let totalSpacing = itemSpacing + self.spacing
            
            if section.itemProperties.shouldIgnoreImageAspectRatioForGroupHeight {
                return ((heightConstant + totalSpacing) * itemFloatCount) - totalSpacing
            } else {
                return (((groupWidth  * aspectRatio) + heightConstant)) * itemFloatCount
            }
            
        } else {
            return (groupWidth  * aspectRatio) + heightConstant
        }
    }
}

extension DisplayModel {
    /// The display mode of this section display
    var displayMode: DisplayMode {
        if width < 500 {
            return .compact
        } else if width < 750 {
            return .standard
        } else if width < 1000{
            return .large
        } else {
            return .extraLarge
        }
    }
}
