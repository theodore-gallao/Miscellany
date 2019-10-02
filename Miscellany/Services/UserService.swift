//
//  UserService.swift
//  Miscellany
//
//  Created by Theodore Gallao on 9/22/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation

/// Interacts with the database for user related data **only**
class UserService {
    
    /// The singleton that represents the *only* instance of this class
    static let shared = UserService()
    
    private init() {}
    
    /// This function must be called *only once* and *before* any other method from this `UserService` is called
    func configure() {}
}
