//
//  Commentable.swift
//  Miscellany
//
//  Created by Theodore Gallao on 10/14/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation

/// Object that are `Commentable` can be commented on, and have comments.  This object must have number of comments, though the number of comments may be more than the count of `comments`.
protocol Commentable {
    
    /// Number of comments of this object. This is not the count of this object's `comments` array, but of the total comments from the database
    var commentCount: Int { get set }
    
    /// The comments on this object
    var comments: [CommentModel] { get set }
}
