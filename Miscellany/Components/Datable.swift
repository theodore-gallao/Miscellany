//
//  Datable.swift
//  Miscellany
//
//  Created by Theodore Gallao on 6/11/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation

/// Objects that are `Datable` can be dated, and must have the variables `dateCreated`, and date `dateUpdated`, of  type `Date` to date it.
protocol Datable {
    
    /// The date this object was created
    var dateCreated: Date { get set }
    
    /// The date this object was updated
    var dateUpdated: Date { get set }
}
