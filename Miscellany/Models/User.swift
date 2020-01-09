//
//  UserModel.swift
//  Miscellany
//
//  Created by Theodore Gallao on 6/19/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

struct BaseUser: Codable {
    var id: String
    
    var firstName: String
    var lastName: String
    var username: String
}

struct User: Databasable {
    var id: String
    var dateCreated: Date
    var dateUpdated: Date
    
    var isRegistered: Bool
    var firstName: String
    var lastName: String
    var email: String
    var username: String
    
    var storyCount: Int
    
    var subscriberCount: Int
    var subscribedCount: Int
    
    var subscriptions: [BaseUser] = []
    var likedGenres: [BaseGenre] = []
}
