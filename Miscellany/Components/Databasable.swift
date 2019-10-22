//
//  Databasable.swift
//  Miscellany
//
//  Created by Theodore Gallao on 6/11/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation

/// Object that are `Databasable` simply can be databased because its components can be coded, identified, and dated. This protocol conforms to `Codable`, `Identifiable`, and `Datable`
protocol Databasable: Codable, Identifiable, Datable { }
