//
//  Describable.swift
//  Miscellany
//
//  Created by Theodore Gallao on 10/14/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation

/// Objects that are `Describable` can be described, and, as such, must have a `description` variable of type `String` to describe it
protocol Describable {
    var description: String { get set }
}
