//
//  Nameable.swift
//  Miscellany
//
//  Created by Theodore Gallao on 10/14/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation

protocol Namable {
    var firstName: String { get set }
    var lastName: String { get set }
    var fullName: String { get }
}

extension Namable {
    var fullName: String {
        return "\(self.firstName) \(self.lastName)"
    }
}
