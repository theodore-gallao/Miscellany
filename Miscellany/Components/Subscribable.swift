//
//  Subscribable.swift
//  Miscellany
//
//  Created by Theodore Gallao on 10/14/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation

/// Objects that conform to this protocol can subscribe and be subscribed to
protocol Subscribable {
    
    /// Number of subscribers of this object
    var subscriberCount: Int { get set }
    
    /// Number of subscribed by this object
    var subscribedCount: Int { get set }
}
