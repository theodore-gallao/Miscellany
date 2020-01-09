//
//  General.swift
//  Miscellany
//
//  Created by Theodore Gallao on 11/15/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

/// The low-cost form of `General`, where only the necessary information is used for to minimize memory usage for UI elements.
struct BaseGeneral: Codable {
    var id: String
    var title: String
    var subtitle: String
    
    /// The type of collection this `General` object is pointing to
    var type: General.GeneralType
}

/// A `General` object refers to a collection of one classification as a whole. For example, a `General` object can refer to the collection of all stories, or all users, but not any more specific than that.
struct General: Databasable {
    enum GeneralType: Int, Codable {
        case articles
        case stories
        case users
        case genres
        case contests
        case tags
    }
    
    var id: String
    var dateCreated: Date
    var dateUpdated: Date
    
    /// The type of collection this `General` object is referring to
    var type: GeneralType
}
