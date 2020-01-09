//
//  Display.swift
//  Miscellany
//
//  Created by Theodore Gallao on 10/22/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

enum DisplayMode {
    case compact
    case standard
    case large
    case extraLarge
    
    static func displayMode(for width: CGFloat) -> DisplayMode {
        if width < 500 {
            return .compact
        } else if width < 750 {
            return .standard
        } else if width < 1000 {
            return .large
        } else {
            return .extraLarge
        }
    }
    
    var directionalLayoutMargins: NSDirectionalEdgeInsets {
        switch self {
            case .compact:
                return NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
            case .standard:
                return NSDirectionalEdgeInsets(top: 0, leading: 32, bottom: 0, trailing: 32)
            case .large:
                return NSDirectionalEdgeInsets(top: 0, leading: 44, bottom: 0, trailing: 44)
            case .extraLarge:
                return NSDirectionalEdgeInsets(top: 0, leading: 64, bottom: 0, trailing: 64)
        }
    }
    
    var spacing: CGFloat {
        switch self {
            case .compact:
                return 10
            case .standard:
                return 15
            case .large:
                return 20
            case .extraLarge:
                return 25
        }
    }
}

struct DisplayProperty<T: Hashable>: Hashable {
    private var compact: T
    private var standard: T
    private var large: T
    private var extraLarge: T
    
    init(value: T) {
        self.compact = value
        self.standard = value
        self.large = value
        self.extraLarge = value
    }
    
    init(compact: T, standard: T, large: T, extraLarge: T) {
        self.compact = compact
        self.standard = standard
        self.large = large
        self.extraLarge = extraLarge
    }
    
    func value(for displayMode: DisplayMode) -> T {
        switch displayMode {
        case .compact: return self.compact
        case .standard: return self.standard
        case .large: return self.large
        case .extraLarge: return self.extraLarge
        }
    }
}

extension DisplayProperty where T == CGFloat {
    var zero: DisplayProperty<T> {
        return DisplayProperty(value: 0)
    }
}

extension DisplayProperty where T == Double {
    var zero: DisplayProperty<T> {
        return DisplayProperty(value: 0)
    }
}

extension DisplayProperty where T == Int {
    var zero: DisplayProperty<T> {
        return DisplayProperty(value: 0)
    }
}
