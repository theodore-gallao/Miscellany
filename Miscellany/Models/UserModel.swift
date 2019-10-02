//
//  UserModel.swift
//  Miscellany
//
//  Created by Theodore Gallao on 6/19/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation

struct UserModel: Databasable {
    var id: String
    var dateCreated: Date
    var dateUpdated: Date
    
    var firstName: String
    var lastName: String
}
