//
//  TagModel.swift
//  Miscellany
//
//  Created by Theodore Gallao on 10/10/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

struct BaseTag {
    var id: String
    
    var title: String
    var storyCount: Int
}

struct Tag: Databasable {
    var id: String
    var dateCreated: Date
    var dateUpdated: Date
    
    var title: String
    
    var storyCount: Int
}
