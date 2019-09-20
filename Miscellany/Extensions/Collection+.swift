//
//  Collection+.swift
//  Miscellany
//
//  Created by Theodore Gallao on 9/19/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation

extension Collection {

    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (optional index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
