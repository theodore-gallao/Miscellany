//
//  StoryService.swift
//  Miscellany
//
//  Created by Theodore Gallao on 9/22/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import Firebase

// MARK: Declaration
/// Interacts with the database for story related data **only**
class StoryService {
    
    /// The singleton that represents the *only* instance of this class
    static let shared = StoryService(storiesReference: Firestore.firestore().collection("stories"))
    
    /// The database reference of the collection that contains all storie
    private let storiesReference: CollectionReference
    
    private var currentUser: UserModel?
    
    private init(storiesReference: CollectionReference) {
        self.storiesReference = storiesReference
    }
    
    /// This function must be called *only once* and *before* any other method from this `StoryService` is called
    func configure() {}
}

// MARK: Get
extension StoryService {
    
}

// MARK: Post
extension StoryService {
    
}
