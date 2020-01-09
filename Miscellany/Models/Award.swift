//
//  AwardModel.swift
//  Miscellany
//
//  Created by Theodore Gallao on 10/1/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation

struct Award: Databasable {
    var id: String
    var dateCreated: Date
    var dateUpdated: Date
    
    var recipient: User
    var title: String
    var description: String
}
