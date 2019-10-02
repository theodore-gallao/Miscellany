//
//  AwardModel.swift
//  Miscellany
//
//  Created by Theodore Gallao on 10/1/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation

struct AwardModel: Databasable {
    var id: String
    var dateCreated: Date
    var dateUpdated: Date
    
    var recipient: UserModel
    var title: String
    var description: String
}
