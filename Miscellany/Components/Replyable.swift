//
//  Replyable.swift
//  Miscellany
//
//  Created by Theodore Gallao on 10/14/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation

protocol Replyable {
    /// Number of replies of this object
    var replyCount: Int { get set }
    
    /// The ID of the parent of this object, or the object to which this is replying.
    var parentId: String? { get set }
}
